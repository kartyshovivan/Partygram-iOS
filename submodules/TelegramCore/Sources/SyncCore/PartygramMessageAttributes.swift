import Foundation
import Postbox

public final class PartygramDeletedMessageAttribute: Equatable, MessageAttribute {
    public let date: Int32

    public init(date: Int32) {
        self.date = date
    }

    required public init(decoder: PostboxDecoder) {
        self.date = decoder.decodeInt32ForKey("d", orElse: 0)
    }

    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeInt32(self.date, forKey: "d")
    }

    public static func ==(lhs: PartygramDeletedMessageAttribute, rhs: PartygramDeletedMessageAttribute) -> Bool {
        return lhs.date == rhs.date
    }
}

public struct PartygramMessageEditHistoryEntry: Equatable, PostboxCoding {
    public let date: Int32
    public let text: String

    public init(date: Int32, text: String) {
        self.date = date
        self.text = text
    }

    public init(decoder: PostboxDecoder) {
        self.date = decoder.decodeInt32ForKey("d", orElse: 0)
        self.text = decoder.decodeStringForKey("t", orElse: "")
    }

    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeInt32(self.date, forKey: "d")
        encoder.encodeString(self.text, forKey: "t")
    }
}

public final class PartygramEditHistoryMessageAttribute: Equatable, MessageAttribute {
    public let entries: [PartygramMessageEditHistoryEntry]

    public init(entries: [PartygramMessageEditHistoryEntry]) {
        self.entries = entries
    }

    required public init(decoder: PostboxDecoder) {
        self.entries = decoder.decodeObjectArrayWithDecoderForKey("e")
    }

    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeObjectArray(self.entries, forKey: "e")
    }

    public static func ==(lhs: PartygramEditHistoryMessageAttribute, rhs: PartygramEditHistoryMessageAttribute) -> Bool {
        return lhs.entries == rhs.entries
    }
}
