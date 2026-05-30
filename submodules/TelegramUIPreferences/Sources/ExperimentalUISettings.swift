import Foundation
import TelegramCore
import SwiftSignalKit

public struct ExperimentalUISettings: Codable, Equatable {
    public struct AccountReactionOverrides: Equatable, Codable {
        public struct Item: Equatable, Codable {
            public var key: MessageReaction.Reaction
            public var messageId: EngineMessage.Id
            public var mediaId: EngineMedia.Id
            
            public init(key: MessageReaction.Reaction, messageId: EngineMessage.Id, mediaId: EngineMedia.Id) {
                self.key = key
                self.messageId = messageId
                self.mediaId = mediaId
            }
        }
        
        public var accountId: Int64
        public var items: [Item]
        
        public init(accountId: Int64, items: [Item]) {
            self.accountId = accountId
            self.items = items
        }
    }
    
    public var keepChatNavigationStack: Bool
    public var skipReadHistory: Bool
    public var hideTypingActivity: Bool
    public var partygramGhostMode: Bool
    public var partygramGhostDontReadMessages: Bool
    public var partygramGhostDontReadStories: Bool
    public var partygramGhostDontSendOnline: Bool
    public var partygramGhostDontSendTyping: Bool
    public var partygramGhostAutoOffline: Bool
    public var partygramGhostReadOnActions: Bool
    public var partygramGhostUseDelay: Bool
    public var partygramGhostSilentSendMode: Int32
    public var partygramGhostSuggestForStories: Bool
    public var partygramGhostLastOnlineTimestamp: Int32
    public var partygramSpySaveDeletedMessages: Bool
    public var partygramSpySaveEditHistory: Bool
    public var partygramSpySaveBotChats: Bool
    public var partygramSpySaveReadDate: Bool
    public var partygramSpySaveLastOnline: Bool
    public var partygramSpySaveAttachments: Bool
    public var partygramSpyAttachmentsFolder: String
    public var partygramSpyMaxFolderSize: Int32
    public var alwaysDisplayTyping: Bool
    public var crashOnLongQueries: Bool
    public var chatListPhotos: Bool
    public var knockoutWallpaper: Bool
    public var foldersTabAtBottom: Bool
    public var preferredVideoCodec: String?
    public var disableVideoAspectScaling: Bool
    public var enableVoipTcp: Bool
    public var experimentalCompatibility: Bool
    public var enableDebugDataDisplay: Bool
    public var fakeGlass: Bool
    public var compressedEmojiCache: Bool
    public var localTranscription: Bool
    public var enableReactionOverrides: Bool
    public var browserExperiment: Bool
    public var accountReactionEffectOverrides: [AccountReactionOverrides]
    public var accountStickerEffectOverrides: [AccountReactionOverrides]
    public var disableQuickReaction: Bool
    public var disableLanguageRecognition: Bool
    public var disableImageContentAnalysis: Bool
    public var disableBackgroundAnimation: Bool
    public var logLanguageRecognition: Bool
    public var storiesExperiment: Bool
    public var storiesJpegExperiment: Bool
    public var crashOnMemoryPressure: Bool
    public var dustEffect: Bool
    public var disableCallV2: Bool
    public var experimentalCallMute: Bool
    public var allowWebViewInspection: Bool
    public var disableReloginTokens: Bool
    public var liveStreamV2: Bool
    public var dynamicStreaming: Bool
    public var enableLocalTranslation: Bool
    public var autoBenchmarkReflectors: Bool?
    public var playerV2: Bool
    public var devRequests: Bool
    public var fakeAds: Bool
    public var conferenceDebug: Bool
    public var checkSerializedData: Bool
    public var allForumsHaveTabs: Bool
    public var debugRatingLayout: Bool
    public var enableUpdates: Bool
    public var enablePWA: Bool
    public var forceClearGlass: Bool
    public var debugRipple: Bool
    public var debugRichText: Bool
    
    public static var defaultSettings: ExperimentalUISettings {
        return ExperimentalUISettings(
            keepChatNavigationStack: false,
            skipReadHistory: false,
            hideTypingActivity: false,
            partygramGhostMode: false,
            partygramGhostDontReadMessages: false,
            partygramGhostDontReadStories: false,
            partygramGhostDontSendOnline: false,
            partygramGhostDontSendTyping: false,
            partygramGhostAutoOffline: false,
            partygramGhostReadOnActions: false,
            partygramGhostUseDelay: false,
            partygramGhostSilentSendMode: 0,
            partygramGhostSuggestForStories: true,
            partygramGhostLastOnlineTimestamp: 0,
            partygramSpySaveDeletedMessages: false,
            partygramSpySaveEditHistory: false,
            partygramSpySaveBotChats: false,
            partygramSpySaveReadDate: false,
            partygramSpySaveLastOnline: false,
            partygramSpySaveAttachments: false,
            partygramSpyAttachmentsFolder: "Saved Attachments",
            partygramSpyMaxFolderSize: 0,
            alwaysDisplayTyping: false,
            crashOnLongQueries: false,
            chatListPhotos: false,
            knockoutWallpaper: false,
            foldersTabAtBottom: false,
            preferredVideoCodec: nil,
            disableVideoAspectScaling: false,
            enableVoipTcp: false,
            experimentalCompatibility: false,
            enableDebugDataDisplay: false,
            fakeGlass: false,
            compressedEmojiCache: false,
            localTranscription: false,
            enableReactionOverrides: false,
            browserExperiment: false,
            accountReactionEffectOverrides: [],
            accountStickerEffectOverrides: [],
            disableQuickReaction: false,
            disableLanguageRecognition: false,
            disableImageContentAnalysis: false,
            disableBackgroundAnimation: false,
            logLanguageRecognition: false,
            storiesExperiment: false,
            storiesJpegExperiment: false,
            crashOnMemoryPressure: false,
            dustEffect: false,
            disableCallV2: false,
            experimentalCallMute: false,
            allowWebViewInspection: false,
            disableReloginTokens: false,
            liveStreamV2: false,
            dynamicStreaming: false,
            enableLocalTranslation: false,
            autoBenchmarkReflectors: nil,
            playerV2: false,
            devRequests: false,
            fakeAds: false,
            conferenceDebug: false,
            checkSerializedData: false,
            allForumsHaveTabs: false,
            debugRatingLayout: false,
            enableUpdates: false,
            enablePWA: false,
            forceClearGlass: false,
            debugRipple: false,
            debugRichText: false
        )
    }
    
    public init(
        keepChatNavigationStack: Bool,
        skipReadHistory: Bool,
        hideTypingActivity: Bool,
        partygramGhostMode: Bool,
        partygramGhostDontReadMessages: Bool,
        partygramGhostDontReadStories: Bool,
        partygramGhostDontSendOnline: Bool,
        partygramGhostDontSendTyping: Bool,
        partygramGhostAutoOffline: Bool,
        partygramGhostReadOnActions: Bool,
        partygramGhostUseDelay: Bool,
        partygramGhostSilentSendMode: Int32,
        partygramGhostSuggestForStories: Bool,
        partygramGhostLastOnlineTimestamp: Int32,
        partygramSpySaveDeletedMessages: Bool,
        partygramSpySaveEditHistory: Bool,
        partygramSpySaveBotChats: Bool,
        partygramSpySaveReadDate: Bool,
        partygramSpySaveLastOnline: Bool,
        partygramSpySaveAttachments: Bool,
        partygramSpyAttachmentsFolder: String,
        partygramSpyMaxFolderSize: Int32,
        alwaysDisplayTyping: Bool,
        crashOnLongQueries: Bool,
        chatListPhotos: Bool,
        knockoutWallpaper: Bool,
        foldersTabAtBottom: Bool,
        preferredVideoCodec: String?,
        disableVideoAspectScaling: Bool,
        enableVoipTcp: Bool,
        experimentalCompatibility: Bool,
        enableDebugDataDisplay: Bool,
        fakeGlass: Bool,
        compressedEmojiCache: Bool,
        localTranscription: Bool,
        enableReactionOverrides: Bool,
        browserExperiment: Bool,
        accountReactionEffectOverrides: [AccountReactionOverrides],
        accountStickerEffectOverrides: [AccountReactionOverrides],
        disableQuickReaction: Bool,
        disableLanguageRecognition: Bool,
        disableImageContentAnalysis: Bool,
        disableBackgroundAnimation: Bool,
        logLanguageRecognition: Bool,
        storiesExperiment: Bool,
        storiesJpegExperiment: Bool,
        crashOnMemoryPressure: Bool,
        dustEffect: Bool,
        disableCallV2: Bool,
        experimentalCallMute: Bool,
        allowWebViewInspection: Bool,
        disableReloginTokens: Bool,
        liveStreamV2: Bool,
        dynamicStreaming: Bool,
        enableLocalTranslation: Bool,
        autoBenchmarkReflectors: Bool?,
        playerV2: Bool,
        devRequests: Bool,
        fakeAds: Bool,
        conferenceDebug: Bool,
        checkSerializedData: Bool,
        allForumsHaveTabs: Bool,
        debugRatingLayout: Bool,
        enableUpdates: Bool,
        enablePWA: Bool,
        forceClearGlass: Bool,
        debugRipple: Bool,
        debugRichText: Bool
    ) {
        self.keepChatNavigationStack = keepChatNavigationStack
        self.skipReadHistory = skipReadHistory
        self.hideTypingActivity = hideTypingActivity
        self.partygramGhostMode = partygramGhostMode
        self.partygramGhostDontReadMessages = partygramGhostDontReadMessages
        self.partygramGhostDontReadStories = partygramGhostDontReadStories
        self.partygramGhostDontSendOnline = partygramGhostDontSendOnline
        self.partygramGhostDontSendTyping = partygramGhostDontSendTyping
        self.partygramGhostAutoOffline = partygramGhostAutoOffline
        self.partygramGhostReadOnActions = partygramGhostReadOnActions
        self.partygramGhostUseDelay = partygramGhostUseDelay
        self.partygramGhostSilentSendMode = partygramGhostSilentSendMode
        self.partygramGhostSuggestForStories = partygramGhostSuggestForStories
        self.partygramGhostLastOnlineTimestamp = partygramGhostLastOnlineTimestamp
        self.partygramSpySaveDeletedMessages = partygramSpySaveDeletedMessages
        self.partygramSpySaveEditHistory = partygramSpySaveEditHistory
        self.partygramSpySaveBotChats = partygramSpySaveBotChats
        self.partygramSpySaveReadDate = partygramSpySaveReadDate
        self.partygramSpySaveLastOnline = partygramSpySaveLastOnline
        self.partygramSpySaveAttachments = partygramSpySaveAttachments
        self.partygramSpyAttachmentsFolder = partygramSpyAttachmentsFolder
        self.partygramSpyMaxFolderSize = partygramSpyMaxFolderSize
        self.alwaysDisplayTyping = alwaysDisplayTyping
        self.crashOnLongQueries = crashOnLongQueries
        self.chatListPhotos = chatListPhotos
        self.knockoutWallpaper = knockoutWallpaper
        self.foldersTabAtBottom = foldersTabAtBottom
        self.preferredVideoCodec = preferredVideoCodec
        self.disableVideoAspectScaling = disableVideoAspectScaling
        self.enableVoipTcp = enableVoipTcp
        self.experimentalCompatibility = experimentalCompatibility
        self.enableDebugDataDisplay = enableDebugDataDisplay
        self.fakeGlass = fakeGlass
        self.compressedEmojiCache = compressedEmojiCache
        self.localTranscription = localTranscription
        self.enableReactionOverrides = enableReactionOverrides
        self.browserExperiment = browserExperiment
        self.accountReactionEffectOverrides = accountReactionEffectOverrides
        self.accountStickerEffectOverrides = accountStickerEffectOverrides
        self.disableQuickReaction = disableQuickReaction
        self.disableLanguageRecognition = disableLanguageRecognition
        self.disableImageContentAnalysis = disableImageContentAnalysis
        self.disableBackgroundAnimation = disableBackgroundAnimation
        self.logLanguageRecognition = logLanguageRecognition
        self.storiesExperiment = storiesExperiment
        self.storiesJpegExperiment = storiesJpegExperiment
        self.crashOnMemoryPressure = crashOnMemoryPressure
        self.dustEffect = dustEffect
        self.disableCallV2 = disableCallV2
        self.experimentalCallMute = experimentalCallMute
        self.allowWebViewInspection = allowWebViewInspection
        self.disableReloginTokens = disableReloginTokens
        self.liveStreamV2 = liveStreamV2
        self.dynamicStreaming = dynamicStreaming
        self.enableLocalTranslation = enableLocalTranslation
        self.autoBenchmarkReflectors = autoBenchmarkReflectors
        self.playerV2 = playerV2
        self.devRequests = devRequests
        self.fakeAds = fakeAds
        self.conferenceDebug = conferenceDebug
        self.checkSerializedData = checkSerializedData
        self.allForumsHaveTabs = allForumsHaveTabs
        self.debugRatingLayout = debugRatingLayout
        self.enableUpdates = enableUpdates
        self.enablePWA = enablePWA
        self.forceClearGlass = forceClearGlass
        self.debugRipple = debugRipple
        self.debugRichText = debugRichText
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringCodingKey.self)

        self.keepChatNavigationStack = (try container.decodeIfPresent(Int32.self, forKey: "keepChatNavigationStack") ?? 0) != 0
        self.skipReadHistory = (try container.decodeIfPresent(Int32.self, forKey: "skipReadHistory") ?? 0) != 0
        self.hideTypingActivity = (try container.decodeIfPresent(Int32.self, forKey: "hideTypingActivity") ?? 0) != 0
        self.partygramGhostMode = try container.decodeIfPresent(Bool.self, forKey: "partygramGhostMode") ?? false
        self.partygramGhostDontReadMessages = try container.decodeIfPresent(Bool.self, forKey: "partygramGhostDontReadMessages") ?? self.skipReadHistory
        self.partygramGhostDontReadStories = try container.decodeIfPresent(Bool.self, forKey: "partygramGhostDontReadStories") ?? self.skipReadHistory
        self.partygramGhostDontSendOnline = try container.decodeIfPresent(Bool.self, forKey: "partygramGhostDontSendOnline") ?? false
        self.partygramGhostDontSendTyping = try container.decodeIfPresent(Bool.self, forKey: "partygramGhostDontSendTyping") ?? self.hideTypingActivity
        self.partygramGhostAutoOffline = try container.decodeIfPresent(Bool.self, forKey: "partygramGhostAutoOffline") ?? false
        self.partygramGhostReadOnActions = try container.decodeIfPresent(Bool.self, forKey: "partygramGhostReadOnActions") ?? false
        self.partygramGhostUseDelay = try container.decodeIfPresent(Bool.self, forKey: "partygramGhostUseDelay") ?? false
        self.partygramGhostSilentSendMode = try container.decodeIfPresent(Int32.self, forKey: "partygramGhostSilentSendMode") ?? 0
        self.partygramGhostSuggestForStories = try container.decodeIfPresent(Bool.self, forKey: "partygramGhostSuggestForStories") ?? true
        self.partygramGhostLastOnlineTimestamp = try container.decodeIfPresent(Int32.self, forKey: "partygramGhostLastOnlineTimestamp") ?? 0
        self.partygramSpySaveDeletedMessages = try container.decodeIfPresent(Bool.self, forKey: "partygramSpySaveDeletedMessages") ?? false
        self.partygramSpySaveEditHistory = try container.decodeIfPresent(Bool.self, forKey: "partygramSpySaveEditHistory") ?? false
        self.partygramSpySaveBotChats = try container.decodeIfPresent(Bool.self, forKey: "partygramSpySaveBotChats") ?? false
        self.partygramSpySaveReadDate = try container.decodeIfPresent(Bool.self, forKey: "partygramSpySaveReadDate") ?? false
        self.partygramSpySaveLastOnline = try container.decodeIfPresent(Bool.self, forKey: "partygramSpySaveLastOnline") ?? false
        self.partygramSpySaveAttachments = try container.decodeIfPresent(Bool.self, forKey: "partygramSpySaveAttachments") ?? false
        self.partygramSpyAttachmentsFolder = try container.decodeIfPresent(String.self, forKey: "partygramSpyAttachmentsFolder") ?? "Saved Attachments"
        self.partygramSpyMaxFolderSize = try container.decodeIfPresent(Int32.self, forKey: "partygramSpyMaxFolderSize") ?? 0
        self.alwaysDisplayTyping = (try container.decodeIfPresent(Int32.self, forKey: "alwaysDisplayTyping") ?? 0) != 0
        self.crashOnLongQueries = (try container.decodeIfPresent(Int32.self, forKey: "crashOnLongQueries") ?? 0) != 0
        self.chatListPhotos = (try container.decodeIfPresent(Int32.self, forKey: "chatListPhotos") ?? 0) != 0
        self.knockoutWallpaper = (try container.decodeIfPresent(Int32.self, forKey: "knockoutWallpaper") ?? 0) != 0
        self.foldersTabAtBottom = (try container.decodeIfPresent(Int32.self, forKey: "foldersTabAtBottom") ?? 0) != 0
        self.preferredVideoCodec = try container.decodeIfPresent(String.self.self, forKey: "preferredVideoCodec")
        self.disableVideoAspectScaling = (try container.decodeIfPresent(Int32.self, forKey: "disableVideoAspectScaling") ?? 0) != 0
        self.enableVoipTcp = (try container.decodeIfPresent(Int32.self, forKey: "enableVoipTcp") ?? 0) != 0
        self.experimentalCompatibility = (try container.decodeIfPresent(Int32.self, forKey: "experimentalCompatibility") ?? 0) != 0
        self.enableDebugDataDisplay = (try container.decodeIfPresent(Int32.self, forKey: "enableDebugDataDisplay") ?? 0) != 0
        self.fakeGlass = (try container.decodeIfPresent(Int32.self, forKey: "fakeGlass") ?? 0) != 0
        self.compressedEmojiCache = (try container.decodeIfPresent(Int32.self, forKey: "compressedEmojiCache") ?? 0) != 0
        self.localTranscription = (try container.decodeIfPresent(Int32.self, forKey: "localTranscription") ?? 0) != 0
        self.enableReactionOverrides = try container.decodeIfPresent(Bool.self, forKey: "enableReactionOverrides") ?? false
        self.browserExperiment = try container.decodeIfPresent(Bool.self, forKey: "browserExperiment") ?? false
        self.accountReactionEffectOverrides = (try? container.decodeIfPresent([AccountReactionOverrides].self, forKey: "accountReactionEffectOverrides")) ?? []
        self.accountStickerEffectOverrides = (try? container.decodeIfPresent([AccountReactionOverrides].self, forKey: "accountStickerEffectOverrides")) ?? []
        self.disableQuickReaction = try container.decodeIfPresent(Bool.self, forKey: "disableQuickReaction") ?? false
        self.disableLanguageRecognition = try container.decodeIfPresent(Bool.self, forKey: "disableLanguageRecognition") ?? false
        self.disableImageContentAnalysis = try container.decodeIfPresent(Bool.self, forKey: "disableImageContentAnalysis") ?? false
        self.disableBackgroundAnimation = try container.decodeIfPresent(Bool.self, forKey: "disableBackgroundAnimation") ?? false
        self.logLanguageRecognition = try container.decodeIfPresent(Bool.self, forKey: "logLanguageRecognition") ?? false
        self.storiesExperiment = try container.decodeIfPresent(Bool.self, forKey: "storiesExperiment") ?? false
        self.storiesJpegExperiment = try container.decodeIfPresent(Bool.self, forKey: "storiesJpegExperiment") ?? false
        self.crashOnMemoryPressure = try container.decodeIfPresent(Bool.self, forKey: "crashOnMemoryPressure") ?? false
        self.dustEffect = try container.decodeIfPresent(Bool.self, forKey: "dustEffect") ?? false
        self.disableCallV2 = try container.decodeIfPresent(Bool.self, forKey: "disableCallV2") ?? false
        self.experimentalCallMute = try container.decodeIfPresent(Bool.self, forKey: "experimentalCallMute") ?? false
        self.allowWebViewInspection = try container.decodeIfPresent(Bool.self, forKey: "allowWebViewInspection") ?? false
        self.disableReloginTokens = try container.decodeIfPresent(Bool.self, forKey: "disableReloginTokens") ?? false
        self.liveStreamV2 = try container.decodeIfPresent(Bool.self, forKey: "liveStreamV2") ?? false
        self.dynamicStreaming = try container.decodeIfPresent(Bool.self, forKey: "dynamicStreaming_v2") ?? false
        self.enableLocalTranslation = try container.decodeIfPresent(Bool.self, forKey: "enableLocalTranslation") ?? false
        self.autoBenchmarkReflectors = try container.decodeIfPresent(Bool.self, forKey: "autoBenchmarkReflectors")
        self.playerV2 = try container.decodeIfPresent(Bool.self, forKey: "playerV2") ?? false
        self.devRequests = try container.decodeIfPresent(Bool.self, forKey: "devRequests") ?? false
        self.fakeAds = try container.decodeIfPresent(Bool.self, forKey: "fakeAds") ?? false
        self.conferenceDebug = try container.decodeIfPresent(Bool.self, forKey: "conferenceDebug") ?? false
        self.checkSerializedData = try container.decodeIfPresent(Bool.self, forKey: "checkSerializedData") ?? false
        self.allForumsHaveTabs = try container.decodeIfPresent(Bool.self, forKey: "allForumsHaveTabs") ?? false
        self.debugRatingLayout = try container.decodeIfPresent(Bool.self, forKey: "debugRatingLayout") ?? false
        self.enableUpdates = try container.decodeIfPresent(Bool.self, forKey: "enableUpdates") ?? false
        self.enablePWA = try container.decodeIfPresent(Bool.self, forKey: "enablePWA") ?? false
        self.forceClearGlass = try container.decodeIfPresent(Bool.self, forKey: "forceClearGlass") ?? false
        self.debugRipple = try container.decodeIfPresent(Bool.self, forKey: "debugRipple") ?? false
        self.debugRichText = try container.decodeIfPresent(Bool.self, forKey: "debugRichText") ?? false
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringCodingKey.self)

        try container.encode((self.keepChatNavigationStack ? 1 : 0) as Int32, forKey: "keepChatNavigationStack")
        try container.encode((self.skipReadHistory ? 1 : 0) as Int32, forKey: "skipReadHistory")
        try container.encode((self.hideTypingActivity ? 1 : 0) as Int32, forKey: "hideTypingActivity")
        try container.encode(self.partygramGhostMode, forKey: "partygramGhostMode")
        try container.encode(self.partygramGhostDontReadMessages, forKey: "partygramGhostDontReadMessages")
        try container.encode(self.partygramGhostDontReadStories, forKey: "partygramGhostDontReadStories")
        try container.encode(self.partygramGhostDontSendOnline, forKey: "partygramGhostDontSendOnline")
        try container.encode(self.partygramGhostDontSendTyping, forKey: "partygramGhostDontSendTyping")
        try container.encode(self.partygramGhostAutoOffline, forKey: "partygramGhostAutoOffline")
        try container.encode(self.partygramGhostReadOnActions, forKey: "partygramGhostReadOnActions")
        try container.encode(self.partygramGhostUseDelay, forKey: "partygramGhostUseDelay")
        try container.encode(self.partygramGhostSilentSendMode, forKey: "partygramGhostSilentSendMode")
        try container.encode(self.partygramGhostSuggestForStories, forKey: "partygramGhostSuggestForStories")
        try container.encode(self.partygramGhostLastOnlineTimestamp, forKey: "partygramGhostLastOnlineTimestamp")
        try container.encode(self.partygramSpySaveDeletedMessages, forKey: "partygramSpySaveDeletedMessages")
        try container.encode(self.partygramSpySaveEditHistory, forKey: "partygramSpySaveEditHistory")
        try container.encode(self.partygramSpySaveBotChats, forKey: "partygramSpySaveBotChats")
        try container.encode(self.partygramSpySaveReadDate, forKey: "partygramSpySaveReadDate")
        try container.encode(self.partygramSpySaveLastOnline, forKey: "partygramSpySaveLastOnline")
        try container.encode(self.partygramSpySaveAttachments, forKey: "partygramSpySaveAttachments")
        try container.encode(self.partygramSpyAttachmentsFolder, forKey: "partygramSpyAttachmentsFolder")
        try container.encode(self.partygramSpyMaxFolderSize, forKey: "partygramSpyMaxFolderSize")
        try container.encode((self.alwaysDisplayTyping ? 1 : 0) as Int32, forKey: "alwaysDisplayTyping")
        try container.encode((self.crashOnLongQueries ? 1 : 0) as Int32, forKey: "crashOnLongQueries")
        try container.encode((self.chatListPhotos ? 1 : 0) as Int32, forKey: "chatListPhotos")
        try container.encode((self.knockoutWallpaper ? 1 : 0) as Int32, forKey: "knockoutWallpaper")
        try container.encode((self.foldersTabAtBottom ? 1 : 0) as Int32, forKey: "foldersTabAtBottom")
        try container.encodeIfPresent(self.preferredVideoCodec, forKey: "preferredVideoCodec")
        try container.encode((self.disableVideoAspectScaling ? 1 : 0) as Int32, forKey: "disableVideoAspectScaling")
        try container.encode((self.enableVoipTcp ? 1 : 0) as Int32, forKey: "enableVoipTcp")
        try container.encode((self.experimentalCompatibility ? 1 : 0) as Int32, forKey: "experimentalCompatibility")
        try container.encode((self.enableDebugDataDisplay ? 1 : 0) as Int32, forKey: "enableDebugDataDisplay")
        try container.encode((self.fakeGlass ? 1 : 0) as Int32, forKey: "fakeGlass")
        try container.encode((self.compressedEmojiCache ? 1 : 0) as Int32, forKey: "compressedEmojiCache")
        try container.encode((self.localTranscription ? 1 : 0) as Int32, forKey: "localTranscription")
        try container.encode(self.enableReactionOverrides, forKey: "enableReactionOverrides")
        try container.encode(self.browserExperiment, forKey: "browserExperiment")
        try container.encode(self.accountReactionEffectOverrides, forKey: "accountReactionEffectOverrides")
        try container.encode(self.accountStickerEffectOverrides, forKey: "accountStickerEffectOverrides")
        try container.encode(self.disableQuickReaction, forKey: "disableQuickReaction")
        try container.encode(self.disableLanguageRecognition, forKey: "disableLanguageRecognition")
        try container.encode(self.disableImageContentAnalysis, forKey: "disableImageContentAnalysis")
        try container.encode(self.disableBackgroundAnimation, forKey: "disableBackgroundAnimation")
        try container.encode(self.logLanguageRecognition, forKey: "logLanguageRecognition")
        try container.encode(self.storiesExperiment, forKey: "storiesExperiment")
        try container.encode(self.storiesJpegExperiment, forKey: "storiesJpegExperiment")
        try container.encode(self.crashOnMemoryPressure, forKey: "crashOnMemoryPressure")
        try container.encode(self.dustEffect, forKey: "dustEffect")
        try container.encode(self.disableCallV2, forKey: "disableCallV2")
        try container.encode(self.experimentalCallMute, forKey: "experimentalCallMute")
        try container.encode(self.allowWebViewInspection, forKey: "allowWebViewInspection")
        try container.encode(self.disableReloginTokens, forKey: "disableReloginTokens")
        try container.encode(self.liveStreamV2, forKey: "liveStreamV2")
        try container.encode(self.dynamicStreaming, forKey: "dynamicStreaming")
        try container.encode(self.enableLocalTranslation, forKey: "enableLocalTranslation")
        try container.encodeIfPresent(self.autoBenchmarkReflectors, forKey: "autoBenchmarkReflectors")
        try container.encodeIfPresent(self.playerV2, forKey: "playerV2")
        try container.encodeIfPresent(self.devRequests, forKey: "devRequests")
        try container.encodeIfPresent(self.fakeAds, forKey: "fakeAds")
        try container.encodeIfPresent(self.conferenceDebug, forKey: "conferenceDebug")
        try container.encodeIfPresent(self.checkSerializedData, forKey: "checkSerializedData")
        try container.encodeIfPresent(self.allForumsHaveTabs, forKey: "allForumsHaveTabs")
        try container.encodeIfPresent(self.debugRatingLayout, forKey: "debugRatingLayout")
        try container.encodeIfPresent(self.enableUpdates, forKey: "enableUpdates")
        try container.encodeIfPresent(self.enablePWA, forKey: "enablePWA")
        try container.encodeIfPresent(self.forceClearGlass, forKey: "forceClearGlass")
        try container.encodeIfPresent(self.debugRipple, forKey: "debugRipple")
        try container.encodeIfPresent(self.debugRichText, forKey: "debugRichText")
    }
}

public func updateExperimentalUISettingsInteractively(accountManager: AccountManager<TelegramAccountManagerTypes>, _ f: @escaping (ExperimentalUISettings) -> ExperimentalUISettings) -> Signal<Void, NoError> {
    return accountManager.transaction { transaction -> Void in
        transaction.updateSharedData(ApplicationSpecificSharedDataKeys.experimentalUISettings, { entry in
            let currentSettings: ExperimentalUISettings
            if let entry = entry?.get(ExperimentalUISettings.self) {
                currentSettings = entry
            } else {
                currentSettings = .defaultSettings
            }
            return SharedPreferencesEntry(f(currentSettings))
        })
    }
}
