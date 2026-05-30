import Foundation
import UIKit
import Display
import SwiftSignalKit
import TelegramCore
import TelegramPresentationData
import TelegramUIPreferences
import ItemListUI
import AccountContext
import AlertUI
import PresentationDataUtils

private final class PartygramSettingsArguments {
    let updateSettings: ((ExperimentalUISettings) -> ExperimentalUISettings) -> Void
    let openSilentMode: () -> Void
    let openFolderSize: () -> Void
    let showPlaceholder: (String) -> Void
    
    init(
        updateSettings: @escaping ((ExperimentalUISettings) -> ExperimentalUISettings) -> Void,
        openSilentMode: @escaping () -> Void,
        openFolderSize: @escaping () -> Void,
        showPlaceholder: @escaping (String) -> Void
    ) {
        self.updateSettings = updateSettings
        self.openSilentMode = openSilentMode
        self.openFolderSize = openFolderSize
        self.showPlaceholder = showPlaceholder
    }
}

private enum PartygramSettingsSection: Int32 {
    case ghost
    case ghostOptions
    case spy
    case spyAttachments
    case spyDatabase
}

private enum PartygramSettingsEntry: ItemListNodeEntry {
    case ghostHeader(String)
    case ghostMode(String, Bool, String)
    case ghostOption(Int32, String, Bool)
    case ghostOptionsInfo(String)
    case readOnActions(String, Bool)
    case readOnActionsInfo(String)
    case useDelay(String, Bool)
    case useDelayInfo(String)
    case silentMode(String, String)
    case silentModeInfo(String)
    case suggestForStories(String, Bool)
    case suggestForStoriesInfo(String)
    
    case spyHeader(String)
    case saveDeletedMessages(String, Bool)
    case saveEditHistory(String, Bool)
    case saveBotChats(String, Bool)
    case saveReadDate(String, Bool)
    case saveReadDateInfo(String)
    case saveLastOnline(String, Bool)
    case saveLastOnlineInfo(String)
    case saveAttachments(String, Bool)
    case attachmentsFolder(String, String)
    case folderSizeHeader(String)
    case folderSize(String, String)
    case folderSizeInfo(String)
    case exportDatabase(String)
    case importDatabase(String)
    case clearDatabase(String)
    
    var section: ItemListSectionId {
        switch self {
        case .ghostHeader, .ghostMode, .ghostOption, .ghostOptionsInfo:
            return PartygramSettingsSection.ghost.rawValue
        case .readOnActions, .readOnActionsInfo, .useDelay, .useDelayInfo, .silentMode, .silentModeInfo, .suggestForStories, .suggestForStoriesInfo:
            return PartygramSettingsSection.ghostOptions.rawValue
        case .spyHeader, .saveDeletedMessages, .saveEditHistory, .saveBotChats, .saveReadDate, .saveReadDateInfo, .saveLastOnline, .saveLastOnlineInfo:
            return PartygramSettingsSection.spy.rawValue
        case .saveAttachments, .attachmentsFolder, .folderSizeHeader, .folderSize, .folderSizeInfo:
            return PartygramSettingsSection.spyAttachments.rawValue
        case .exportDatabase, .importDatabase, .clearDatabase:
            return PartygramSettingsSection.spyDatabase.rawValue
        }
    }
    
    var stableId: Int32 {
        switch self {
        case .ghostHeader:
            return 0
        case .ghostMode:
            return 1
        case let .ghostOption(index, _, _):
            return 10 + index
        case .ghostOptionsInfo:
            return 20
        case .readOnActions:
            return 21
        case .readOnActionsInfo:
            return 22
        case .useDelay:
            return 23
        case .useDelayInfo:
            return 24
        case .silentMode:
            return 25
        case .silentModeInfo:
            return 26
        case .suggestForStories:
            return 27
        case .suggestForStoriesInfo:
            return 28
        case .spyHeader:
            return 100
        case .saveDeletedMessages:
            return 101
        case .saveEditHistory:
            return 102
        case .saveBotChats:
            return 103
        case .saveReadDate:
            return 104
        case .saveReadDateInfo:
            return 105
        case .saveLastOnline:
            return 106
        case .saveLastOnlineInfo:
            return 107
        case .saveAttachments:
            return 108
        case .attachmentsFolder:
            return 109
        case .folderSizeHeader:
            return 110
        case .folderSize:
            return 111
        case .folderSizeInfo:
            return 112
        case .exportDatabase:
            return 113
        case .importDatabase:
            return 114
        case .clearDatabase:
            return 115
        }
    }
    
    static func ==(lhs: PartygramSettingsEntry, rhs: PartygramSettingsEntry) -> Bool {
        switch lhs {
        case let .ghostHeader(text):
            if case .ghostHeader(text) = rhs { return true } else { return false }
        case let .ghostMode(text, value, label):
            if case .ghostMode(text, value, label) = rhs { return true } else { return false }
        case let .ghostOption(index, text, value):
            if case .ghostOption(index, text, value) = rhs { return true } else { return false }
        case let .ghostOptionsInfo(text):
            if case .ghostOptionsInfo(text) = rhs { return true } else { return false }
        case let .readOnActions(text, value):
            if case .readOnActions(text, value) = rhs { return true } else { return false }
        case let .readOnActionsInfo(text):
            if case .readOnActionsInfo(text) = rhs { return true } else { return false }
        case let .useDelay(text, value):
            if case .useDelay(text, value) = rhs { return true } else { return false }
        case let .useDelayInfo(text):
            if case .useDelayInfo(text) = rhs { return true } else { return false }
        case let .silentMode(text, value):
            if case .silentMode(text, value) = rhs { return true } else { return false }
        case let .silentModeInfo(text):
            if case .silentModeInfo(text) = rhs { return true } else { return false }
        case let .suggestForStories(text, value):
            if case .suggestForStories(text, value) = rhs { return true } else { return false }
        case let .suggestForStoriesInfo(text):
            if case .suggestForStoriesInfo(text) = rhs { return true } else { return false }
        case let .spyHeader(text):
            if case .spyHeader(text) = rhs { return true } else { return false }
        case let .saveDeletedMessages(text, value):
            if case .saveDeletedMessages(text, value) = rhs { return true } else { return false }
        case let .saveEditHistory(text, value):
            if case .saveEditHistory(text, value) = rhs { return true } else { return false }
        case let .saveBotChats(text, value):
            if case .saveBotChats(text, value) = rhs { return true } else { return false }
        case let .saveReadDate(text, value):
            if case .saveReadDate(text, value) = rhs { return true } else { return false }
        case let .saveReadDateInfo(text):
            if case .saveReadDateInfo(text) = rhs { return true } else { return false }
        case let .saveLastOnline(text, value):
            if case .saveLastOnline(text, value) = rhs { return true } else { return false }
        case let .saveLastOnlineInfo(text):
            if case .saveLastOnlineInfo(text) = rhs { return true } else { return false }
        case let .saveAttachments(text, value):
            if case .saveAttachments(text, value) = rhs { return true } else { return false }
        case let .attachmentsFolder(text, value):
            if case .attachmentsFolder(text, value) = rhs { return true } else { return false }
        case let .folderSizeHeader(text):
            if case .folderSizeHeader(text) = rhs { return true } else { return false }
        case let .folderSize(text, value):
            if case .folderSize(text, value) = rhs { return true } else { return false }
        case let .folderSizeInfo(text):
            if case .folderSizeInfo(text) = rhs { return true } else { return false }
        case let .exportDatabase(text):
            if case .exportDatabase(text) = rhs { return true } else { return false }
        case let .importDatabase(text):
            if case .importDatabase(text) = rhs { return true } else { return false }
        case let .clearDatabase(text):
            if case .clearDatabase(text) = rhs { return true } else { return false }
        }
    }
    
    static func <(lhs: PartygramSettingsEntry, rhs: PartygramSettingsEntry) -> Bool {
        return lhs.stableId < rhs.stableId
    }
    
    func item(presentationData: ItemListPresentationData, arguments: Any) -> ListViewItem {
        let arguments = arguments as! PartygramSettingsArguments
        switch self {
        case let .ghostHeader(text), let .spyHeader(text), let .folderSizeHeader(text):
            return ItemListSectionHeaderItem(presentationData: presentationData, text: text, sectionId: self.section)
        case let .ghostMode(text, value, label):
            return ItemListSwitchItem(presentationData: presentationData, systemStyle: .glass, title: "\(text)  \(label)", value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.updateSettings { settings in
                    var settings = settings
                    settings.partygramGhostMode = value
                    applyPartygramDerivedSettings(&settings)
                    return settings
                }
            })
        case let .ghostOption(index, text, value):
            return ItemListCheckboxItem(presentationData: presentationData, systemStyle: .glass, title: text, style: .left, checked: value, zeroSeparatorInsets: false, sectionId: self.section, action: {
                arguments.updateSettings { settings in
                    var settings = settings
                    switch index {
                    case 0:
                        settings.partygramGhostDontReadMessages = !settings.partygramGhostDontReadMessages
                    case 1:
                        settings.partygramGhostDontReadStories = !settings.partygramGhostDontReadStories
                    case 2:
                        settings.partygramGhostDontSendOnline = !settings.partygramGhostDontSendOnline
                    case 3:
                        settings.partygramGhostDontSendTyping = !settings.partygramGhostDontSendTyping
                    case 4:
                        settings.partygramGhostAutoOffline = !settings.partygramGhostAutoOffline
                    default:
                        break
                    }
                    applyPartygramDerivedSettings(&settings)
                    return settings
                }
            })
        case let .ghostOptionsInfo(text), let .readOnActionsInfo(text), let .useDelayInfo(text), let .silentModeInfo(text), let .suggestForStoriesInfo(text), let .saveReadDateInfo(text), let .saveLastOnlineInfo(text), let .folderSizeInfo(text):
            return ItemListTextItem(presentationData: presentationData, text: .plain(text), sectionId: self.section)
        case let .readOnActions(text, value):
            return ItemListSwitchItem(presentationData: presentationData, systemStyle: .glass, title: text, value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.updateSettings { settings in
                    var settings = settings
                    settings.partygramGhostReadOnActions = value
                    return settings
                }
            })
        case let .useDelay(text, value):
            return ItemListSwitchItem(presentationData: presentationData, systemStyle: .glass, title: text, value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.updateSettings { settings in
                    var settings = settings
                    settings.partygramGhostUseDelay = value
                    return settings
                }
            })
        case let .silentMode(text, value):
            return ItemListDisclosureItem(presentationData: presentationData, systemStyle: .glass, title: text, label: value, labelStyle: .text, sectionId: self.section, style: .blocks, action: {
                arguments.openSilentMode()
            })
        case let .suggestForStories(text, value):
            return ItemListSwitchItem(presentationData: presentationData, systemStyle: .glass, title: text, value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.updateSettings { settings in
                    var settings = settings
                    settings.partygramGhostSuggestForStories = value
                    return settings
                }
            })
        case let .saveDeletedMessages(text, value):
            return ItemListSwitchItem(presentationData: presentationData, systemStyle: .glass, title: text, value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.updateSettings { settings in
                    var settings = settings
                    settings.partygramSpySaveDeletedMessages = value
                    return settings
                }
            })
        case let .saveEditHistory(text, value):
            return ItemListSwitchItem(presentationData: presentationData, systemStyle: .glass, title: text, value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.updateSettings { settings in
                    var settings = settings
                    settings.partygramSpySaveEditHistory = value
                    return settings
                }
            })
        case let .saveBotChats(text, value):
            return ItemListSwitchItem(presentationData: presentationData, systemStyle: .glass, title: text, value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.updateSettings { settings in
                    var settings = settings
                    settings.partygramSpySaveBotChats = value
                    return settings
                }
            })
        case let .saveReadDate(text, value):
            return ItemListSwitchItem(presentationData: presentationData, systemStyle: .glass, title: text, value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.updateSettings { settings in
                    var settings = settings
                    settings.partygramSpySaveReadDate = value
                    return settings
                }
            })
        case let .saveLastOnline(text, value):
            return ItemListSwitchItem(presentationData: presentationData, systemStyle: .glass, title: text, value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.updateSettings { settings in
                    var settings = settings
                    settings.partygramSpySaveLastOnline = value
                    return settings
                }
            })
        case let .saveAttachments(text, value):
            return ItemListSwitchItem(presentationData: presentationData, systemStyle: .glass, title: text, value: value, sectionId: self.section, style: .blocks, updated: { value in
                arguments.updateSettings { settings in
                    var settings = settings
                    settings.partygramSpySaveAttachments = value
                    return settings
                }
            })
        case let .attachmentsFolder(text, value):
            return ItemListDisclosureItem(presentationData: presentationData, systemStyle: .glass, title: text, label: value, labelStyle: .text, sectionId: self.section, style: .blocks, disclosureStyle: .none, action: {
                arguments.showPlaceholder("Папка вложений будет использована для сохранённых вложений.")
            })
        case let .folderSize(text, value):
            return ItemListDisclosureItem(presentationData: presentationData, systemStyle: .glass, title: text, label: value, labelStyle: .text, sectionId: self.section, style: .blocks, action: {
                arguments.openFolderSize()
            })
        case let .exportDatabase(text):
            return ItemListActionItem(presentationData: presentationData, systemStyle: .glass, title: text, kind: .generic, alignment: .natural, sectionId: self.section, style: .blocks, action: {
                arguments.showPlaceholder("Экспорт базы данных Partygram будет подключён к локальному хранилищу.")
            })
        case let .importDatabase(text):
            return ItemListActionItem(presentationData: presentationData, systemStyle: .glass, title: text, kind: .generic, alignment: .natural, sectionId: self.section, style: .blocks, action: {
                arguments.showPlaceholder("Импорт базы данных Partygram будет подключён к локальному хранилищу.")
            })
        case let .clearDatabase(text):
            return ItemListActionItem(presentationData: presentationData, systemStyle: .glass, title: text, kind: .destructive, alignment: .natural, sectionId: self.section, style: .blocks, action: {
                arguments.showPlaceholder("Очистка базы данных Partygram будет подключена к локальному хранилищу.")
            })
        }
    }
}

private func applyPartygramDerivedSettings(_ settings: inout ExperimentalUISettings) {
    settings.skipReadHistory = settings.partygramGhostMode && (settings.partygramGhostDontReadMessages || settings.partygramGhostDontReadStories)
    settings.hideTypingActivity = settings.partygramGhostMode && settings.partygramGhostDontSendTyping
}

private func partygramGhostEnabledCount(_ settings: ExperimentalUISettings) -> Int {
    var count = 0
    if settings.partygramGhostDontReadMessages { count += 1 }
    if settings.partygramGhostDontReadStories { count += 1 }
    if settings.partygramGhostDontSendOnline { count += 1 }
    if settings.partygramGhostDontSendTyping { count += 1 }
    if settings.partygramGhostAutoOffline { count += 1 }
    return count
}

private func partygramSilentModeTitle(_ value: Int32) -> String {
    switch value {
    case 1:
        return "Всегда"
    default:
        return "Никогда"
    }
}

private func partygramFolderSizeTitle(_ value: Int32) -> String {
    switch value {
    case 0:
        return "300 MB"
    case 1:
        return "1 GB"
    case 2:
        return "2 GB"
    case 3:
        return "5 GB"
    case 4:
        return "16 GB"
    default:
        return "∞"
    }
}

private func partygramSettingsEntries(settings: ExperimentalUISettings) -> [PartygramSettingsEntry] {
    var entries: [PartygramSettingsEntry] = []
    
    entries.append(.ghostHeader("Режим призрака"))
    entries.append(.ghostMode("Режим призрака", settings.partygramGhostMode, "\(partygramGhostEnabledCount(settings))/5"))
    if settings.partygramGhostMode {
        entries.append(.ghostOption(0, "Не читать сообщения", settings.partygramGhostDontReadMessages))
        entries.append(.ghostOption(1, "Не читать истории", settings.partygramGhostDontReadStories))
        entries.append(.ghostOption(2, "Не отправлять «онлайн»", settings.partygramGhostDontSendOnline))
        entries.append(.ghostOption(3, "Не отправлять «печатает»", settings.partygramGhostDontSendTyping))
        entries.append(.ghostOption(4, "Автоматический «офлайн»", settings.partygramGhostAutoOffline))
        entries.append(.ghostOptionsInfo("Зажмите любую опцию, чтобы зафиксировать её значение."))
    }
    entries.append(.readOnActions("Читать при действиях", settings.partygramGhostReadOnActions))
    entries.append(.readOnActionsInfo("Автоматически читает сообщение при отправке нового или при реакции на сообщение."))
    entries.append(.useDelay("Использовать отложку", settings.partygramGhostUseDelay))
    entries.append(.useDelayInfo("Автоматически ставит задержку в ~12 секунд при отправке сообщений. При использовании этой функции вы не будете появляться в сети. Не рекомендуется использовать на слабом интернете."))
    entries.append(.silentMode("Отправлять без звука", partygramSilentModeTitle(settings.partygramGhostSilentSendMode)))
    entries.append(.silentModeInfo("Отправляет сообщения по умолчанию без звука."))
    entries.append(.suggestForStories("Предлагать призрака для сторис", settings.partygramGhostSuggestForStories))
    entries.append(.suggestForStoriesInfo("Показывает предупреждение перед открытием сторис, предлагая включить режим призрака."))
    
    entries.append(.spyHeader("Режим шпиона"))
    entries.append(.saveDeletedMessages("Сохранять удалённые сообщения", settings.partygramSpySaveDeletedMessages))
    entries.append(.saveEditHistory("Сохранять историю правок", settings.partygramSpySaveEditHistory))
    entries.append(.saveBotChats("Сохранять в чатах с ботами", settings.partygramSpySaveBotChats))
    entries.append(.saveReadDate("Сохранять дату чтения", settings.partygramSpySaveReadDate))
    entries.append(.saveReadDateInfo("Локально сохраняет данные о чтении сообщений. Будет использоваться, если Telegram не предоставит дату чтения."))
    entries.append(.saveLastOnline("Сохранять последний онлайн", settings.partygramSpySaveLastOnline))
    entries.append(.saveLastOnlineInfo("Сохраняет последний известный онлайн для людей со скрытым последним посещением. Вы сможете очень приблизительно увидеть, когда они были последний раз онлайн."))
    entries.append(.saveAttachments("Сохранять вложения", settings.partygramSpySaveAttachments))
    entries.append(.attachmentsFolder("Папка вложений", settings.partygramSpyAttachmentsFolder))
    entries.append(.folderSizeHeader("Максимальный размер папки"))
    entries.append(.folderSize("Максимальный размер папки", partygramFolderSizeTitle(settings.partygramSpyMaxFolderSize)))
    entries.append(.folderSizeInfo("Если размер папки превышает этот лимит, самые старые вложения будут удалены с устройства."))
    entries.append(.exportDatabase("Экспорт базы данных"))
    entries.append(.importDatabase("Импорт базы данных"))
    entries.append(.clearDatabase("Очистить"))
    
    return entries
}

public func partygramSettingsController(context: AccountContext) -> ViewController {
    var presentControllerImpl: ((ViewController) -> Void)?
    
    let updateSettings: (((ExperimentalUISettings) -> ExperimentalUISettings) -> Void) = { f in
        let _ = updateExperimentalUISettingsInteractively(accountManager: context.sharedContext.accountManager, { settings in
            return f(settings)
        }).start()
    }
    
    let showPlaceholder: (String) -> Void = { text in
        let presentationData = context.sharedContext.currentPresentationData.with { $0 }
        presentControllerImpl?(textAlertController(context: context, title: "Partygram", text: text, actions: [
            TextAlertAction(type: .genericAction, title: presentationData.strings.Common_OK, action: {})
        ]))
    }
    
    let arguments = PartygramSettingsArguments(
        updateSettings: updateSettings,
        openSilentMode: {
            let presentationData = context.sharedContext.currentPresentationData.with { $0 }
            let controller = ActionSheetController(presentationData: presentationData)
            controller.setItemGroups([
                ActionSheetItemGroup(items: [
                    ActionSheetButtonItem(title: "Никогда", action: { [weak controller] in
                        controller?.dismissAnimated()
                        updateSettings { settings in
                            var settings = settings
                            settings.partygramGhostSilentSendMode = 0
                            return settings
                        }
                    }),
                    ActionSheetButtonItem(title: "Всегда", action: { [weak controller] in
                        controller?.dismissAnimated()
                        updateSettings { settings in
                            var settings = settings
                            settings.partygramGhostSilentSendMode = 1
                            return settings
                        }
                    })
                ]),
                ActionSheetItemGroup(items: [
                    ActionSheetButtonItem(title: presentationData.strings.Common_Cancel, action: { [weak controller] in
                        controller?.dismissAnimated()
                    })
                ])
            ])
            presentControllerImpl?(controller)
        },
        openFolderSize: {
            let presentationData = context.sharedContext.currentPresentationData.with { $0 }
            let controller = ActionSheetController(presentationData: presentationData)
            var items: [ActionSheetItem] = []
            for value in Int32(0) ... Int32(5) {
                items.append(ActionSheetButtonItem(title: partygramFolderSizeTitle(value), action: { [weak controller] in
                    controller?.dismissAnimated()
                    updateSettings { settings in
                        var settings = settings
                        settings.partygramSpyMaxFolderSize = value
                        return settings
                    }
                }))
            }
            controller.setItemGroups([
                ActionSheetItemGroup(items: items),
                ActionSheetItemGroup(items: [
                    ActionSheetButtonItem(title: presentationData.strings.Common_Cancel, action: { [weak controller] in
                        controller?.dismissAnimated()
                    })
                ])
            ])
            presentControllerImpl?(controller)
        },
        showPlaceholder: showPlaceholder
    )
    
    let signal = combineLatest(
        context.sharedContext.presentationData,
        context.sharedContext.accountManager.sharedData(keys: [ApplicationSpecificSharedDataKeys.experimentalUISettings])
    )
    |> map { presentationData, sharedData -> (ItemListControllerState, (ItemListNodeState, Any)) in
        let settings = sharedData.entries[ApplicationSpecificSharedDataKeys.experimentalUISettings]?.get(ExperimentalUISettings.self) ?? .defaultSettings
        let controllerState = ItemListControllerState(presentationData: ItemListPresentationData(presentationData), title: .text("Настройки Partygram"), leftNavigationButton: nil, rightNavigationButton: nil, backNavigationButton: ItemListBackButton(title: presentationData.strings.Common_Back), animateChanges: false)
        let listState = ItemListNodeState(presentationData: ItemListPresentationData(presentationData), entries: partygramSettingsEntries(settings: settings), style: .blocks, animateChanges: false)
        return (controllerState, (listState, arguments))
    }
    
    let controller = ItemListController(context: context, state: signal)
    presentControllerImpl = { [weak controller] c in
        controller?.present(c, in: .window(.root), with: nil)
    }
    return controller
}
