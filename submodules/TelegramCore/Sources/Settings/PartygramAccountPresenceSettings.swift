import Foundation

public struct PartygramAccountPresenceSettings: Codable, Equatable {
    public var remoteLastOnlineTimestamp: Int32
    public var remoteOnlineUntilTimestamp: Int32
    
    public static var defaultSettings: PartygramAccountPresenceSettings {
        return PartygramAccountPresenceSettings(remoteLastOnlineTimestamp: 0, remoteOnlineUntilTimestamp: 0)
    }
    
    public init(remoteLastOnlineTimestamp: Int32, remoteOnlineUntilTimestamp: Int32 = 0) {
        self.remoteLastOnlineTimestamp = remoteLastOnlineTimestamp
        self.remoteOnlineUntilTimestamp = remoteOnlineUntilTimestamp
    }

    private enum CodingKeys: String, CodingKey {
        case remoteLastOnlineTimestamp
        case remoteOnlineUntilTimestamp
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.remoteLastOnlineTimestamp = try container.decodeIfPresent(Int32.self, forKey: .remoteLastOnlineTimestamp) ?? 0
        self.remoteOnlineUntilTimestamp = try container.decodeIfPresent(Int32.self, forKey: .remoteOnlineUntilTimestamp) ?? 0
    }
    
    public func withUpdatedRemoteLastOnlineTimestamp(_ timestamp: Int32) -> PartygramAccountPresenceSettings {
        var result = self
        if timestamp > result.remoteLastOnlineTimestamp {
            result.remoteLastOnlineTimestamp = timestamp
        }
        result.remoteOnlineUntilTimestamp = 0
        return result
    }

    public func withUpdatedRemoteOnlineUntilTimestamp(_ timestamp: Int32) -> PartygramAccountPresenceSettings {
        var result = self
        if timestamp > result.remoteLastOnlineTimestamp && timestamp > result.remoteOnlineUntilTimestamp {
            result.remoteOnlineUntilTimestamp = timestamp
        }
        return result
    }
}
