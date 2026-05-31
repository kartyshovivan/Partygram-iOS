import Foundation
import TelegramApi
import Postbox
import SwiftSignalKit
import MtProtoKit

private typealias SignalKitTimer = SwiftSignalKit.Timer


private final class AccountPresenceManagerImpl {
    private let queue: Queue
    private let network: Network
    let isPerformingUpdate = ValuePromise<Bool>(false, ignoreRepeated: true)
    
    private var shouldKeepOnlinePresenceDisposable: Disposable?
    private let currentRequestDisposable = MetaDisposable()
    private var onlineTimer: SignalKitTimer?
    private var retryTimer: SignalKitTimer?
    private var currentRequestId: Int = 0
    
    private var desiredOnline: Bool = false
    private var wasOnline: Bool = false
    
    init(queue: Queue, shouldKeepOnlinePresence: Signal<Bool, NoError>, network: Network) {
        self.queue = queue
        self.network = network
        
        self.shouldKeepOnlinePresenceDisposable = (shouldKeepOnlinePresence
        |> distinctUntilChanged
        |> deliverOn(self.queue)).start(next: { [weak self] value in
            guard let `self` = self else {
                return
            }
            self.desiredOnline = value
            if self.wasOnline != value {
                self.wasOnline = value
                self.updatePresence(value)
            }
        })
    }
    
    deinit {
        assert(self.queue.isCurrent())
        self.shouldKeepOnlinePresenceDisposable?.dispose()
        self.currentRequestDisposable.dispose()
        self.onlineTimer?.invalidate()
        self.retryTimer?.invalidate()
    }

    private func scheduleOnlineRefresh() {
        self.onlineTimer?.invalidate()
        let timer = SignalKitTimer(timeout: 30.0, repeat: false, completion: { [weak self] in
            guard let strongSelf = self, strongSelf.desiredOnline else {
                return
            }
            strongSelf.updatePresence(true)
        }, queue: self.queue)
        self.onlineTimer = timer
        timer.start()
    }

    private func scheduleRetry(isOnline: Bool) {
        self.retryTimer?.invalidate()
        let timer = SignalKitTimer(timeout: isOnline ? 5.0 : 2.0, repeat: false, completion: { [weak self] in
            guard let strongSelf = self, strongSelf.desiredOnline == isOnline else {
                return
            }
            strongSelf.updatePresence(isOnline)
        }, queue: self.queue)
        self.retryTimer = timer
        timer.start()
    }
    
    private func updatePresence(_ isOnline: Bool) {
        self.retryTimer?.invalidate()
        self.retryTimer = nil

        let request: Signal<Api.Bool, MTRpcError>
        if isOnline {
            self.onlineTimer?.invalidate()
            self.onlineTimer = nil
            request = self.network.request(Api.functions.account.updateStatus(offline: .boolFalse))
        } else {
            self.onlineTimer?.invalidate()
            self.onlineTimer = nil
            request = self.network.request(Api.functions.account.updateStatus(offline: .boolTrue))
        }

        self.currentRequestId += 1
        let requestId = self.currentRequestId
        self.isPerformingUpdate.set(true)
        self.currentRequestDisposable.set((request
        |> map { _ -> Bool in
            return true
        }
        |> `catch` { _ -> Signal<Bool, NoError> in
            return .single(false)
        }
        |> deliverOn(self.queue)).start(next: { [weak self] succeeded in
            guard let strongSelf = self, strongSelf.currentRequestId == requestId else {
                return
            }
            if succeeded {
                if isOnline && strongSelf.desiredOnline {
                    strongSelf.scheduleOnlineRefresh()
                }
            } else if strongSelf.desiredOnline == isOnline {
                strongSelf.scheduleRetry(isOnline: isOnline)
            }
        }, completed: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            if strongSelf.currentRequestId == requestId {
                strongSelf.isPerformingUpdate.set(false)
            }
        }))
    }

    func forceOfflineUpdate() {
        self.desiredOnline = false
        self.wasOnline = false
        self.updatePresence(false)
    }
}

final class AccountPresenceManager {
    private let queue = Queue()
    private let impl: QueueLocalObject<AccountPresenceManagerImpl>
    
    init(shouldKeepOnlinePresence: Signal<Bool, NoError>, network: Network) {
        let queue = self.queue
        self.impl = QueueLocalObject(queue: self.queue, generate: {
            return AccountPresenceManagerImpl(queue: queue, shouldKeepOnlinePresence: shouldKeepOnlinePresence, network: network)
        })
    }
    
    func isPerformingUpdate() -> Signal<Bool, NoError> {
        return Signal { subscriber in
            let disposable = MetaDisposable()
            self.impl.with { impl in
                disposable.set(impl.isPerformingUpdate.get().start(next: { value in
                    subscriber.putNext(value)
                }))
            }
            return disposable
        }
    }

    func forceOfflineUpdate() {
        self.impl.with { impl in
            impl.forceOfflineUpdate()
        }
    }
}
