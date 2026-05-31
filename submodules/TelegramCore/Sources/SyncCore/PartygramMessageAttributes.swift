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

func partygramAttributesWithDeletedMessage(_ attributes: [MessageAttribute], date: Int32) -> [MessageAttribute] {
    var result = attributes.filter { !($0 is PartygramDeletedMessageAttribute) }
    result.append(PartygramDeletedMessageAttribute(date: date))
    return result
}

func partygramStoreMessageWithDeletedAttribute(_ message: StoreMessage, date: Int32) -> StoreMessage {
    return message.withUpdatedAttributes(partygramAttributesWithDeletedMessage(message.attributes, date: date))
}

func markPartygramMessageDeleted(transaction: Transaction, id: MessageId, timestamp: Int32) {
    transaction.updateMessage(id, update: { message in
        return .update(StoreMessage(id: message.id, customStableId: nil, globallyUniqueId: message.globallyUniqueId, groupingKey: message.groupingKey, threadId: message.threadId, timestamp: message.timestamp, flags: StoreMessageFlags(message.flags), tags: message.tags, globalTags: message.globalTags, localTags: message.localTags, forwardInfo: message.forwardInfo.flatMap(StoreMessageForwardInfo.init), authorId: message.author?.id, text: message.text, attributes: partygramAttributesWithDeletedMessage(message.attributes, date: timestamp), media: message.media))
    })
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
