import Foundation

public struct PartygramAccountPresenceSettings: Codable, Equatable {
    public var remoteLastOnlineTimestamp: Int32
    
    public static var defaultSettings: PartygramAccountPresenceSettings {
        return PartygramAccountPresenceSettings(remoteLastOnlineTimestamp: 0)
    }
    
    public init(remoteLastOnlineTimestamp: Int32) {
        self.remoteLastOnlineTimestamp = remoteLastOnlineTimestamp
    }
    
    public func withUpdatedRemoteLastOnlineTimestamp(_ timestamp: Int32) -> PartygramAccountPresenceSettings {
        var result = self
        if result.remoteLastOnlineTimestamp < timestamp {
            result.remoteLastOnlineTimestamp = timestamp
        }
        return result
    }
}
