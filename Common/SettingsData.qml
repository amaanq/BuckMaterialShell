pragma Singleton

pragma ComponentBehavior: Bound

import QtCore
import QtQuick
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Services

Singleton {
    id: root

    readonly property bool isGreeterMode: Quickshell.env("DYKWABI_RUN_GREETER") === "1" || Quickshell.env("DYKWABI_RUN_GREETER") === "true"

    enum Position {
        Top,
        Bottom,
        Left,
        Right
    }

    enum AnimationSpeed {
        None,
        Shortest,
        Short,
        Medium,
        Long
    }

    // Theme settings
    property string currentThemeName: "blue"
    property string customThemeFile: ""
    property string matugenScheme: "scheme-tonal-spot"
    property real buckBarTransparency: 1.0
    property real buckBarWidgetTransparency: 1.0
    property real popupTransparency: 1.0
    property real dockTransparency: 1
    property bool use24HourClock: true
    property bool useFahrenheit: false
    property bool nightModeEnabled: false
    property string weatherLocation: "New York, NY"
    property string weatherCoordinates: "40.7128,-74.0060"
    property bool useAutoLocation: false
    property bool showLauncherButton: true
    property bool showWorkspaceSwitcher: true
    property bool showFocusedWindow: true
    property bool showWeather: true
    property bool showMusic: true
    property bool showClipboard: true
    property bool showCpuUsage: true
    property bool showMemUsage: true
    property bool showCpuTemp: true
    property bool showGpuTemp: true
    property int selectedGpuIndex: 0
    property var enabledGpuPciIds: []
    property bool showSystemTray: true
    property bool showClock: true
    property bool showNotificationButton: true
    property bool showBattery: true
    property bool showControlCenterButton: true
    property bool controlCenterShowNetworkIcon: true
    property bool controlCenterShowBluetoothIcon: true
    property bool controlCenterShowAudioIcon: true
    property var controlCenterWidgets: [
        {"id": "volumeSlider", "enabled": true, "width": 50},
        {"id": "brightnessSlider", "enabled": true, "width": 50},
        {"id": "wifi", "enabled": true, "width": 50},
        {"id": "bluetooth", "enabled": true, "width": 50},
        {"id": "audioOutput", "enabled": true, "width": 50},
        {"id": "audioInput", "enabled": true, "width": 50},
        {"id": "nightMode", "enabled": true, "width": 50},
        {"id": "darkMode", "enabled": true, "width": 50}
    ]
    property bool showWorkspaceIndex: false
    property bool showWorkspacePadding: false
    property bool showWorkspaceApps: false
    property int maxWorkspaceIcons: 3
    property bool workspacesPerMonitor: true
    property var workspaceNameIcons: ({})
    property bool waveProgressEnabled: true
    property bool clockCompactMode: false
    property bool focusedWindowCompactMode: false
    property bool runningAppsCompactMode: true
    property bool runningAppsCurrentWorkspace: false
    property string clockDateFormat: ""
    property string lockDateFormat: ""
    property int mediaSize: 1
    property var buckBarLeftWidgets: ["launcherButton", "workspaceSwitcher", "focusedWindow"]
    property var buckBarCenterWidgets: ["music", "clock", "weather"]
    property var buckBarRightWidgets: ["systemTray", "clipboard", "cpuUsage", "memUsage", "notificationButton", "battery", "controlCenterButton"]
    property var buckBarWidgetOrder: []
    property alias buckBarLeftWidgetsModel: leftWidgetsModel
    property alias buckBarCenterWidgetsModel: centerWidgetsModel
    property alias buckBarRightWidgetsModel: rightWidgetsModel
    property string appLauncherViewMode: "list"
    property string spotlightModalViewMode: "list"
    property string networkPreference: "auto"
    property string iconTheme: "System Default"
    property var availableIconThemes: ["System Default"]
    property string systemDefaultIconTheme: ""
    property bool qt5ctAvailable: false
    property bool qt6ctAvailable: false
    property bool gtkAvailable: false
    property bool useOSLogo: false
    property string osLogoColorOverride: ""
    property real osLogoBrightness: 0.5
    property real osLogoContrast: 1
    property bool weatherEnabled: true
    property string fontFamily: "Inter Variable"
    property string monoFontFamily: "Fira Code"
    property int fontWeight: Font.Normal
    property real fontScale: 1.0
    property bool notepadUseMonospace: true
    property string notepadFontFamily: ""
    property real notepadFontSize: 14
    property bool notepadShowLineNumbers: false
    property real notepadTransparencyOverride: -1
    property real notepadLastCustomTransparency: 0.7

    onNotepadUseMonospaceChanged: saveSettings()
    onNotepadFontFamilyChanged: saveSettings()
    onNotepadFontSizeChanged: saveSettings()
    onNotepadShowLineNumbersChanged: saveSettings()
    onNotepadTransparencyOverrideChanged: {
        if (notepadTransparencyOverride > 0) {
            notepadLastCustomTransparency = notepadTransparencyOverride
        }
        saveSettings()
    }
    onNotepadLastCustomTransparencyChanged: saveSettings()
    property bool gtkThemingEnabled: false
    property bool qtThemingEnabled: false
    property bool showDock: false
    property bool dockAutoHide: false
    property bool dockGroupByApp: false
    property bool dockOpenOnOverview: false
    property int dockPosition: SettingsData.Position.Bottom
    property real dockSpacing: 4
    property real dockBottomGap: 0
    property real cornerRadius: 12
    property bool notificationOverlayEnabled: false
    property bool buckBarAutoHide: false
    property bool buckBarOpenOnOverview: false
    property bool buckBarVisible: true
    property real buckBarSpacing: 4
    property real buckBarBottomGap: 0
    property real buckBarInnerPadding: 4
    property bool buckBarSquareCorners: false
    property bool buckBarNoBackground: false
    property bool buckBarGothCornersEnabled: false
    property int buckBarPosition: SettingsData.Position.Top
    property bool buckBarIsVertical: buckBarPosition === SettingsData.Position.Left || buckBarPosition === SettingsData.Position.Right
    property bool lockScreenShowPowerActions: true
    property bool hideBrightnessSlider: false
    property string widgetBackgroundColor: "sch"
    property string surfaceBase: "s"
    property int notificationTimeoutLow: 5000
    property int notificationTimeoutNormal: 5000
    property int notificationTimeoutCritical: 0
    property int notificationPopupPosition: SettingsData.Position.Top
    property var screenPreferences: ({})
    property int animationSpeed: SettingsData.AnimationSpeed.Short
    readonly property string defaultFontFamily: "Inter Variable"
    readonly property string defaultMonoFontFamily: "Fira Code"
    readonly property string _homeUrl: StandardPaths.writableLocation(StandardPaths.HomeLocation)
    readonly property string _configUrl: StandardPaths.writableLocation(StandardPaths.ConfigLocation)
    readonly property string _configDir: Paths.strip(_configUrl)

    signal forceBuckBarLayoutRefresh
    signal forceDockLayoutRefresh
    signal widgetDataChanged
    signal workspaceIconsUpdated

    property bool _loading: false

    property var pluginSettings: ({})

    function getEffectiveTimeFormat() {
        if (use24HourClock) {
            return Locale.ShortFormat
        } else {
            return "h:mm AP"
        }
    }

    function getEffectiveClockDateFormat() {
        return clockDateFormat && clockDateFormat.length > 0 ? clockDateFormat : "ddd d"
    }

    function getEffectiveLockDateFormat() {
        return lockDateFormat && lockDateFormat.length > 0 ? lockDateFormat : Locale.LongFormat
    }

    function initializeListModels() {
        // ! Hack-ish to add all properties to the listmodel once
        // ! allows the properties to be bound on new widget addtions
        var dummyItem = {
            "widgetId": "dummy",
            "enabled": true,
            "size": 20,
            "selectedGpuIndex": 0,
            "pciId": "",
            "mountPath": "/"
        }
        leftWidgetsModel.append(dummyItem)
        centerWidgetsModel.append(dummyItem)
        rightWidgetsModel.append(dummyItem)

        updateListModel(leftWidgetsModel, buckBarLeftWidgets)
        updateListModel(centerWidgetsModel, buckBarCenterWidgets)
        updateListModel(rightWidgetsModel, buckBarRightWidgets)
    }

    function loadSettings() {
        _loading = true
        parseSettings(settingsFile.text())
        _loading = false
    }

    function parseSettings(content) {
        _loading = true
        try {
            if (content && content.trim()) {
                var settings = JSON.parse(content)
                // Auto-migrate from old theme system
                if (settings.themeIndex !== undefined || settings.themeIsDynamic !== undefined) {
                    const themeNames = ["blue", "deepBlue", "purple", "green", "orange", "red", "cyan", "pink", "amber", "coral"]
                    if (settings.themeIsDynamic) {
                        currentThemeName = "dynamic"
                    } else if (settings.themeIndex >= 0 && settings.themeIndex < themeNames.length) {
                        currentThemeName = themeNames[settings.themeIndex]
                    }
                    console.log("Auto-migrated theme from index", settings.themeIndex, "to", currentThemeName)
                } else {
                    currentThemeName = settings.currentThemeName !== undefined ? settings.currentThemeName : "blue"
                }
                customThemeFile = settings.customThemeFile !== undefined ? settings.customThemeFile : ""
                matugenScheme = settings.matugenScheme !== undefined ? settings.matugenScheme : "scheme-tonal-spot"
                buckBarTransparency = settings.buckBarTransparency !== undefined ? (settings.buckBarTransparency > 1 ? settings.buckBarTransparency / 100 : settings.buckBarTransparency) : (settings.topBarTransparency !== undefined ? (settings.topBarTransparency > 1 ? settings.topBarTransparency / 100 : settings.topBarTransparency) : 1.0)
                buckBarWidgetTransparency = settings.buckBarWidgetTransparency !== undefined ? (settings.buckBarWidgetTransparency > 1 ? settings.buckBarWidgetTransparency / 100 : settings.buckBarWidgetTransparency) : (settings.topBarWidgetTransparency !== undefined ? (settings.topBarWidgetTransparency > 1 ? settings.topBarWidgetTransparency / 100 : settings.topBarWidgetTransparency) : 1.0)
                popupTransparency = settings.popupTransparency !== undefined ? (settings.popupTransparency > 1 ? settings.popupTransparency / 100 : settings.popupTransparency) : 1.0
                dockTransparency = settings.dockTransparency !== undefined ? (settings.dockTransparency > 1 ? settings.dockTransparency / 100 : settings.dockTransparency) : 1
                use24HourClock = settings.use24HourClock !== undefined ? settings.use24HourClock : true
                useFahrenheit = settings.useFahrenheit !== undefined ? settings.useFahrenheit : false
                nightModeEnabled = settings.nightModeEnabled !== undefined ? settings.nightModeEnabled : false
                weatherLocation = settings.weatherLocation !== undefined ? settings.weatherLocation : "New York, NY"
                weatherCoordinates = settings.weatherCoordinates !== undefined ? settings.weatherCoordinates : "40.7128,-74.0060"
                useAutoLocation = settings.useAutoLocation !== undefined ? settings.useAutoLocation : false
                weatherEnabled = settings.weatherEnabled !== undefined ? settings.weatherEnabled : true
                showLauncherButton = settings.showLauncherButton !== undefined ? settings.showLauncherButton : true
                showWorkspaceSwitcher = settings.showWorkspaceSwitcher !== undefined ? settings.showWorkspaceSwitcher : true
                showFocusedWindow = settings.showFocusedWindow !== undefined ? settings.showFocusedWindow : true
                showWeather = settings.showWeather !== undefined ? settings.showWeather : true
                showMusic = settings.showMusic !== undefined ? settings.showMusic : true
                showClipboard = settings.showClipboard !== undefined ? settings.showClipboard : true
                showCpuUsage = settings.showCpuUsage !== undefined ? settings.showCpuUsage : true
                showMemUsage = settings.showMemUsage !== undefined ? settings.showMemUsage : true
                showCpuTemp = settings.showCpuTemp !== undefined ? settings.showCpuTemp : true
                showGpuTemp = settings.showGpuTemp !== undefined ? settings.showGpuTemp : true
                selectedGpuIndex = settings.selectedGpuIndex !== undefined ? settings.selectedGpuIndex : 0
                enabledGpuPciIds = settings.enabledGpuPciIds !== undefined ? settings.enabledGpuPciIds : []
                showSystemTray = settings.showSystemTray !== undefined ? settings.showSystemTray : true
                showClock = settings.showClock !== undefined ? settings.showClock : true
                showNotificationButton = settings.showNotificationButton !== undefined ? settings.showNotificationButton : true
                showBattery = settings.showBattery !== undefined ? settings.showBattery : true
                showControlCenterButton = settings.showControlCenterButton !== undefined ? settings.showControlCenterButton : true
                controlCenterShowNetworkIcon = settings.controlCenterShowNetworkIcon !== undefined ? settings.controlCenterShowNetworkIcon : true
                controlCenterShowBluetoothIcon = settings.controlCenterShowBluetoothIcon !== undefined ? settings.controlCenterShowBluetoothIcon : true
                controlCenterShowAudioIcon = settings.controlCenterShowAudioIcon !== undefined ? settings.controlCenterShowAudioIcon : true
                controlCenterWidgets = settings.controlCenterWidgets !== undefined ? settings.controlCenterWidgets : [
                    {"id": "volumeSlider", "enabled": true, "width": 50},
                    {"id": "brightnessSlider", "enabled": true, "width": 50},
                    {"id": "wifi", "enabled": true, "width": 50},
                    {"id": "bluetooth", "enabled": true, "width": 50},
                    {"id": "audioOutput", "enabled": true, "width": 50},
                    {"id": "audioInput", "enabled": true, "width": 50},
                    {"id": "nightMode", "enabled": true, "width": 50},
                    {"id": "darkMode", "enabled": true, "width": 50}
                ]
                showWorkspaceIndex = settings.showWorkspaceIndex !== undefined ? settings.showWorkspaceIndex : false
                showWorkspacePadding = settings.showWorkspacePadding !== undefined ? settings.showWorkspacePadding : false
                showWorkspaceApps = settings.showWorkspaceApps !== undefined ? settings.showWorkspaceApps : false
                maxWorkspaceIcons = settings.maxWorkspaceIcons !== undefined ? settings.maxWorkspaceIcons : 3
                workspaceNameIcons = settings.workspaceNameIcons !== undefined ? settings.workspaceNameIcons : ({})
                workspacesPerMonitor = settings.workspacesPerMonitor !== undefined ? settings.workspacesPerMonitor : true
                waveProgressEnabled = settings.waveProgressEnabled !== undefined ? settings.waveProgressEnabled : true
                clockCompactMode = settings.clockCompactMode !== undefined ? settings.clockCompactMode : false
                focusedWindowCompactMode = settings.focusedWindowCompactMode !== undefined ? settings.focusedWindowCompactMode : false
                runningAppsCompactMode = settings.runningAppsCompactMode !== undefined ? settings.runningAppsCompactMode : true
                runningAppsCurrentWorkspace = settings.runningAppsCurrentWorkspace !== undefined ? settings.runningAppsCurrentWorkspace : false
                clockDateFormat = settings.clockDateFormat !== undefined ? settings.clockDateFormat : ""
                lockDateFormat = settings.lockDateFormat !== undefined ? settings.lockDateFormat : ""
                mediaSize = settings.mediaSize !== undefined ? settings.mediaSize : (settings.mediaCompactMode !== undefined ? (settings.mediaCompactMode ? 0 : 1) : 1)
                if (settings.buckBarWidgetOrder || settings.topBarWidgetOrder) {
                    var widgetOrder = settings.buckBarWidgetOrder || settings.topBarWidgetOrder
                    buckBarLeftWidgets = widgetOrder.filter(w => {
                                                                              return ["launcherButton", "workspaceSwitcher", "focusedWindow"].includes(w)
                                                                          })
                    buckBarCenterWidgets = widgetOrder.filter(w => {
                                                                                return ["clock", "music", "weather"].includes(w)
                                                                            })
                    buckBarRightWidgets = widgetOrder.filter(w => {
                                                                               return ["systemTray", "clipboard", "systemResources", "notificationButton", "battery", "controlCenterButton"].includes(w)
                                                                           })
                } else {
                    var leftWidgets = settings.buckBarLeftWidgets !== undefined ? settings.buckBarLeftWidgets : (settings.topBarLeftWidgets !== undefined ? settings.topBarLeftWidgets : ["launcherButton", "workspaceSwitcher", "focusedWindow"])
                    var centerWidgets = settings.buckBarCenterWidgets !== undefined ? settings.buckBarCenterWidgets : (settings.topBarCenterWidgets !== undefined ? settings.topBarCenterWidgets : ["music", "clock", "weather"])
                    var rightWidgets = settings.buckBarRightWidgets !== undefined ? settings.buckBarRightWidgets : (settings.topBarRightWidgets !== undefined ? settings.topBarRightWidgets : ["systemTray", "clipboard", "cpuUsage", "memUsage", "notificationButton", "battery", "controlCenterButton"])
                    buckBarLeftWidgets = leftWidgets
                    buckBarCenterWidgets = centerWidgets
                    buckBarRightWidgets = rightWidgets
                    updateListModel(leftWidgetsModel, leftWidgets)
                    updateListModel(centerWidgetsModel, centerWidgets)
                    updateListModel(rightWidgetsModel, rightWidgets)
                }
                appLauncherViewMode = settings.appLauncherViewMode !== undefined ? settings.appLauncherViewMode : "list"
                spotlightModalViewMode = settings.spotlightModalViewMode !== undefined ? settings.spotlightModalViewMode : "list"
                networkPreference = settings.networkPreference !== undefined ? settings.networkPreference : "auto"
                iconTheme = settings.iconTheme !== undefined ? settings.iconTheme : "System Default"
                useOSLogo = settings.useOSLogo !== undefined ? settings.useOSLogo : false
                osLogoColorOverride = settings.osLogoColorOverride !== undefined ? settings.osLogoColorOverride : ""
                osLogoBrightness = settings.osLogoBrightness !== undefined ? settings.osLogoBrightness : 0.5
                osLogoContrast = settings.osLogoContrast !== undefined ? settings.osLogoContrast : 1
                fontFamily = settings.fontFamily !== undefined ? settings.fontFamily : defaultFontFamily
                monoFontFamily = settings.monoFontFamily !== undefined ? settings.monoFontFamily : defaultMonoFontFamily
                fontWeight = settings.fontWeight !== undefined ? settings.fontWeight : Font.Normal
                fontScale = settings.fontScale !== undefined ? settings.fontScale : 1.0
                notepadUseMonospace = settings.notepadUseMonospace !== undefined ? settings.notepadUseMonospace : true
                notepadFontFamily = settings.notepadFontFamily !== undefined ? settings.notepadFontFamily : ""
                notepadFontSize = settings.notepadFontSize !== undefined ? settings.notepadFontSize : 14
                notepadShowLineNumbers = settings.notepadShowLineNumbers !== undefined ? settings.notepadShowLineNumbers : false
                notepadTransparencyOverride = settings.notepadTransparencyOverride !== undefined ? settings.notepadTransparencyOverride : -1
                notepadLastCustomTransparency = settings.notepadLastCustomTransparency !== undefined ? settings.notepadLastCustomTransparency : 0.95
                gtkThemingEnabled = settings.gtkThemingEnabled !== undefined ? settings.gtkThemingEnabled : false
                qtThemingEnabled = settings.qtThemingEnabled !== undefined ? settings.qtThemingEnabled : false
                showDock = settings.showDock !== undefined ? settings.showDock : false
                dockAutoHide = settings.dockAutoHide !== undefined ? settings.dockAutoHide : false
                dockGroupByApp = settings.dockGroupByApp !== undefined ? settings.dockGroupByApp : false
                dockPosition = settings.dockPosition !== undefined ? settings.dockPosition : SettingsData.Position.Bottom
                dockSpacing = settings.dockSpacing !== undefined ? settings.dockSpacing : 4
                dockBottomGap = settings.dockBottomGap !== undefined ? settings.dockBottomGap : 0
                cornerRadius = settings.cornerRadius !== undefined ? settings.cornerRadius : 12
                notificationOverlayEnabled = settings.notificationOverlayEnabled !== undefined ? settings.notificationOverlayEnabled : false
                buckBarAutoHide = settings.buckBarAutoHide !== undefined ? settings.buckBarAutoHide : (settings.topBarAutoHide !== undefined ? settings.topBarAutoHide : false)
                buckBarOpenOnOverview = settings.buckBarOpenOnOverview !== undefined ? settings.buckBarOpenOnOverview : (settings.topBarOpenOnOverview !== undefined ? settings.topBarOpenOnOverview : false)
                buckBarVisible = settings.buckBarVisible !== undefined ? settings.buckBarVisible : (settings.topBarVisible !== undefined ? settings.topBarVisible : true)
                dockOpenOnOverview = settings.dockOpenOnOverview !== undefined ? settings.dockOpenOnOverview : false
                notificationTimeoutLow = settings.notificationTimeoutLow !== undefined ? settings.notificationTimeoutLow : 5000
                notificationTimeoutNormal = settings.notificationTimeoutNormal !== undefined ? settings.notificationTimeoutNormal : 5000
                notificationTimeoutCritical = settings.notificationTimeoutCritical !== undefined ? settings.notificationTimeoutCritical : 0
                notificationPopupPosition = settings.notificationPopupPosition !== undefined ? settings.notificationPopupPosition : SettingsData.Position.Top
                buckBarSpacing = settings.buckBarSpacing !== undefined ? settings.buckBarSpacing : (settings.topBarSpacing !== undefined ? settings.topBarSpacing : 4)
                buckBarBottomGap = settings.buckBarBottomGap !== undefined ? settings.buckBarBottomGap : (settings.topBarBottomGap !== undefined ? settings.topBarBottomGap : 0)
                buckBarInnerPadding = settings.buckBarInnerPadding !== undefined ? settings.buckBarInnerPadding : (settings.topBarInnerPadding !== undefined ? settings.topBarInnerPadding : 4)
                buckBarSquareCorners = settings.buckBarSquareCorners !== undefined ? settings.buckBarSquareCorners : (settings.topBarSquareCorners !== undefined ? settings.topBarSquareCorners : false)
                buckBarNoBackground = settings.buckBarNoBackground !== undefined ? settings.buckBarNoBackground : (settings.topBarNoBackground !== undefined ? settings.topBarNoBackground : false)
                buckBarGothCornersEnabled = settings.buckBarGothCornersEnabled !== undefined ? settings.buckBarGothCornersEnabled : (settings.topBarGothCornersEnabled !== undefined ? settings.topBarGothCornersEnabled : false)
                buckBarPosition = settings.buckBarPosition !== undefined ? settings.buckBarPosition : (settings.buckBarAtBottom !== undefined ? (settings.buckBarAtBottom ? SettingsData.Position.Bottom : SettingsData.Position.Top) : (settings.topBarAtBottom !== undefined ? (settings.topBarAtBottom ? SettingsData.Position.Bottom : SettingsData.Position.Top) : SettingsData.Position.Top))
                lockScreenShowPowerActions = settings.lockScreenShowPowerActions !== undefined ? settings.lockScreenShowPowerActions : true
                hideBrightnessSlider = settings.hideBrightnessSlider !== undefined ? settings.hideBrightnessSlider : false
                widgetBackgroundColor = settings.widgetBackgroundColor !== undefined ? settings.widgetBackgroundColor : "sch"
                surfaceBase = settings.surfaceBase !== undefined ? settings.surfaceBase : "s"
                screenPreferences = settings.screenPreferences !== undefined ? settings.screenPreferences : ({})
                pluginSettings = settings.pluginSettings !== undefined ? settings.pluginSettings : ({})
                animationSpeed = settings.animationSpeed !== undefined ? settings.animationSpeed : SettingsData.AnimationSpeed.Short
                applyStoredTheme()
                detectAvailableIconThemes()
                detectQtTools()
                updateGtkIconTheme(iconTheme)
                applyStoredIconTheme()
            } else {
                applyStoredTheme()
            }
        } catch (e) {
            applyStoredTheme()
        } finally {
            _loading = false
        }
    }

    function saveSettings() {
        if (_loading)
            return
        settingsFile.setText(JSON.stringify({
                                                "currentThemeName": currentThemeName,
                                                "customThemeFile": customThemeFile,
                                                "matugenScheme": matugenScheme,
                                                "buckBarTransparency": buckBarTransparency,
                                                "buckBarWidgetTransparency": buckBarWidgetTransparency,
                                                "popupTransparency": popupTransparency,
                                                "dockTransparency": dockTransparency,
                                                "use24HourClock": use24HourClock,
                                                "useFahrenheit": useFahrenheit,
                                                "nightModeEnabled": nightModeEnabled,
                                                "weatherLocation": weatherLocation,
                                                "weatherCoordinates": weatherCoordinates,
                                                "useAutoLocation": useAutoLocation,
                                                "weatherEnabled": weatherEnabled,
                                                "showLauncherButton": showLauncherButton,
                                                "showWorkspaceSwitcher": showWorkspaceSwitcher,
                                                "showFocusedWindow": showFocusedWindow,
                                                "showWeather": showWeather,
                                                "showMusic": showMusic,
                                                "showClipboard": showClipboard,
                                                "showCpuUsage": showCpuUsage,
                                                "showMemUsage": showMemUsage,
                                                "showCpuTemp": showCpuTemp,
                                                "showGpuTemp": showGpuTemp,
                                                "selectedGpuIndex": selectedGpuIndex,
                                                "enabledGpuPciIds": enabledGpuPciIds,
                                                "showSystemTray": showSystemTray,
                                                "showClock": showClock,
                                                "showNotificationButton": showNotificationButton,
                                                "showBattery": showBattery,
                                                "showControlCenterButton": showControlCenterButton,
                                                "controlCenterShowNetworkIcon": controlCenterShowNetworkIcon,
                                                "controlCenterShowBluetoothIcon": controlCenterShowBluetoothIcon,
                                                "controlCenterShowAudioIcon": controlCenterShowAudioIcon,
                                                "controlCenterWidgets": controlCenterWidgets,
                                                "showWorkspaceIndex": showWorkspaceIndex,
                                                "showWorkspacePadding": showWorkspacePadding,
                                                "showWorkspaceApps": showWorkspaceApps,
                                                "maxWorkspaceIcons": maxWorkspaceIcons,
                                                "workspacesPerMonitor": workspacesPerMonitor,
                                                "workspaceNameIcons": workspaceNameIcons,
                                                "waveProgressEnabled": waveProgressEnabled,
                                                "clockCompactMode": clockCompactMode,
                                                "focusedWindowCompactMode": focusedWindowCompactMode,
                                                "runningAppsCompactMode": runningAppsCompactMode,
                                                "runningAppsCurrentWorkspace": runningAppsCurrentWorkspace,
                                                "clockDateFormat": clockDateFormat,
                                                "lockDateFormat": lockDateFormat,
                                                "mediaSize": mediaSize,
                                                "buckBarLeftWidgets": buckBarLeftWidgets,
                                                "buckBarCenterWidgets": buckBarCenterWidgets,
                                                "buckBarRightWidgets": buckBarRightWidgets,
                                                "appLauncherViewMode": appLauncherViewMode,
                                                "spotlightModalViewMode": spotlightModalViewMode,
                                                "networkPreference": networkPreference,
                                                "iconTheme": iconTheme,
                                                "useOSLogo": useOSLogo,
                                                "osLogoColorOverride": osLogoColorOverride,
                                                "osLogoBrightness": osLogoBrightness,
                                                "osLogoContrast": osLogoContrast,
                                                "fontFamily": fontFamily,
                                                "monoFontFamily": monoFontFamily,
                                                "fontWeight": fontWeight,
                                                "fontScale": fontScale,
                                                "notepadUseMonospace": notepadUseMonospace,
                                                "notepadFontFamily": notepadFontFamily,
                                                "notepadFontSize": notepadFontSize,
                                                "notepadShowLineNumbers": notepadShowLineNumbers,
                                                "notepadTransparencyOverride": notepadTransparencyOverride,
                                                "notepadLastCustomTransparency": notepadLastCustomTransparency,
                                                "gtkThemingEnabled": gtkThemingEnabled,
                                                "qtThemingEnabled": qtThemingEnabled,
                                                "showDock": showDock,
                                                "dockAutoHide": dockAutoHide,
                                                "dockGroupByApp": dockGroupByApp,
                                                "dockOpenOnOverview": dockOpenOnOverview,
                                                "dockPosition": dockPosition,
                                                "dockSpacing": dockSpacing,
                                                "dockBottomGap": dockBottomGap,
                                                "cornerRadius": cornerRadius,
                                                "notificationOverlayEnabled": notificationOverlayEnabled,
                                                "buckBarAutoHide": buckBarAutoHide,
                                                "buckBarOpenOnOverview": buckBarOpenOnOverview,
                                                "buckBarVisible": buckBarVisible,
                                                "buckBarSpacing": buckBarSpacing,
                                                "buckBarBottomGap": buckBarBottomGap,
                                                "buckBarInnerPadding": buckBarInnerPadding,
                                                "buckBarSquareCorners": buckBarSquareCorners,
                                                "buckBarNoBackground": buckBarNoBackground,
                                                "buckBarGothCornersEnabled": buckBarGothCornersEnabled,
                                                "buckBarPosition": buckBarPosition,
                                                "lockScreenShowPowerActions": lockScreenShowPowerActions,
                                                "hideBrightnessSlider": hideBrightnessSlider,
                                                "widgetBackgroundColor": widgetBackgroundColor,
                                                "surfaceBase": surfaceBase,
                                                "notificationTimeoutLow": notificationTimeoutLow,
                                                "notificationTimeoutNormal": notificationTimeoutNormal,
                                                "notificationTimeoutCritical": notificationTimeoutCritical,
                                                "notificationPopupPosition": notificationPopupPosition,
                                                "screenPreferences": screenPreferences,
                                                "pluginSettings": pluginSettings,
                                                "animationSpeed": animationSpeed
                                            }, null, 2))
    }

    function setShowWorkspaceIndex(enabled) {
        showWorkspaceIndex = enabled
        saveSettings()
    }

    function setShowWorkspacePadding(enabled) {
        showWorkspacePadding = enabled
        saveSettings()
    }

    function setShowWorkspaceApps(enabled) {
        showWorkspaceApps = enabled
        saveSettings()
    }

    function setMaxWorkspaceIcons(maxIcons) {
        maxWorkspaceIcons = maxIcons
        saveSettings()
    }

    function setWorkspacesPerMonitor(enabled) {
        workspacesPerMonitor = enabled
        saveSettings()
    }

    function setWaveProgressEnabled(enabled) {
        waveProgressEnabled = enabled
        saveSettings()
    }

    function setWorkspaceNameIcon(workspaceName, iconData) {
        var iconMap = JSON.parse(JSON.stringify(workspaceNameIcons))
        iconMap[workspaceName] = iconData
        workspaceNameIcons = iconMap
        saveSettings()
        workspaceIconsUpdated()
    }

    function removeWorkspaceNameIcon(workspaceName) {
        var iconMap = JSON.parse(JSON.stringify(workspaceNameIcons))
        delete iconMap[workspaceName]
        workspaceNameIcons = iconMap
        saveSettings()
        workspaceIconsUpdated()
    }

    function getWorkspaceNameIcon(workspaceName) {
        return workspaceNameIcons[workspaceName] || null
    }

    function hasNamedWorkspaces() {
        if (typeof NiriService === "undefined" || !CompositorService.isNiri)
            return false

        for (var i = 0; i < NiriService.allWorkspaces.length; i++) {
            var ws = NiriService.allWorkspaces[i]
            if (ws.name && ws.name.trim() !== "")
                return true
        }
        return false
    }

    function getNamedWorkspaces() {
        var namedWorkspaces = []
        if (typeof NiriService === "undefined" || !CompositorService.isNiri)
            return namedWorkspaces

        for (const ws of NiriService.allWorkspaces) {
            if (ws.name && ws.name.trim() !== "") {
                namedWorkspaces.push(ws.name)
            }
        }
        return namedWorkspaces
    }

    function setClockCompactMode(enabled) {
        clockCompactMode = enabled
        saveSettings()
    }

    function setFocusedWindowCompactMode(enabled) {
        focusedWindowCompactMode = enabled
        saveSettings()
    }

    function setRunningAppsCompactMode(enabled) {
        runningAppsCompactMode = enabled
        saveSettings()
    }

    function setRunningAppsCurrentWorkspace(enabled) {
        runningAppsCurrentWorkspace = enabled
        saveSettings()
    }

    function setClockDateFormat(format) {
        clockDateFormat = format || ""
        saveSettings()
    }

    function setLockDateFormat(format) {
        lockDateFormat = format || ""
        saveSettings()
    }

    function setMediaSize(size) {
        mediaSize = size
        saveSettings()
    }

    function applyStoredTheme() {
        if (typeof Theme !== "undefined")
            Theme.switchTheme(currentThemeName, false, false)
        else
            Qt.callLater(() => {
                             if (typeof Theme !== "undefined")
                             Theme.switchTheme(currentThemeName, false, false)
                         })
    }

    function setTheme(themeName) {
        currentThemeName = themeName
        saveSettings()
    }

    function setCustomThemeFile(filePath) {
        customThemeFile = filePath
        saveSettings()
    }

    function setMatugenScheme(scheme) {
        var normalized = scheme || "scheme-tonal-spot"
        if (matugenScheme === normalized)
            return

        matugenScheme = normalized
        saveSettings()

        if (typeof Theme !== "undefined") {
            Theme.generateSystemThemesFromCurrentTheme()
        }
    }

    function setBuckBarTransparency(transparency) {
        buckBarTransparency = transparency
        saveSettings()
    }

    function setBuckBarWidgetTransparency(transparency) {
        buckBarWidgetTransparency = transparency
        saveSettings()
    }

    function setPopupTransparency(transparency) {
        popupTransparency = transparency
        saveSettings()
    }

    function setDockTransparency(transparency) {
        dockTransparency = transparency
        saveSettings()
    }

    // New preference setters
    function setClockFormat(use24Hour) {
        use24HourClock = use24Hour
        saveSettings()
    }

    function setTemperatureUnit(fahrenheit) {
        useFahrenheit = fahrenheit
        saveSettings()
    }

    function setNightModeEnabled(enabled) {
        nightModeEnabled = enabled
        saveSettings()
    }

    // Widget visibility setters
    function setShowLauncherButton(enabled) {
        showLauncherButton = enabled
        saveSettings()
    }

    function setShowWorkspaceSwitcher(enabled) {
        showWorkspaceSwitcher = enabled
        saveSettings()
    }

    function setShowFocusedWindow(enabled) {
        showFocusedWindow = enabled
        saveSettings()
    }

    function setShowWeather(enabled) {
        showWeather = enabled
        saveSettings()
    }

    function setShowMusic(enabled) {
        showMusic = enabled
        saveSettings()
    }

    function setShowClipboard(enabled) {
        showClipboard = enabled
        saveSettings()
    }

    function setShowCpuUsage(enabled) {
        showCpuUsage = enabled
        saveSettings()
    }

    function setShowMemUsage(enabled) {
        showMemUsage = enabled
        saveSettings()
    }

    function setShowCpuTemp(enabled) {
        showCpuTemp = enabled
        saveSettings()
    }

    function setShowGpuTemp(enabled) {
        showGpuTemp = enabled
        saveSettings()
    }

    function setSelectedGpuIndex(index) {
        selectedGpuIndex = index
        saveSettings()
    }

    function setEnabledGpuPciIds(pciIds) {
        enabledGpuPciIds = pciIds
        saveSettings()
    }

    function setShowSystemTray(enabled) {
        showSystemTray = enabled
        saveSettings()
    }

    function setShowClock(enabled) {
        showClock = enabled
        saveSettings()
    }

    function setShowNotificationButton(enabled) {
        showNotificationButton = enabled
        saveSettings()
    }

    function setShowBattery(enabled) {
        showBattery = enabled
        saveSettings()
    }

    function setShowControlCenterButton(enabled) {
        showControlCenterButton = enabled
        saveSettings()
    }

    function setControlCenterShowNetworkIcon(enabled) {
        controlCenterShowNetworkIcon = enabled
        saveSettings()
    }

    function setControlCenterShowBluetoothIcon(enabled) {
        controlCenterShowBluetoothIcon = enabled
        saveSettings()
    }

    function setControlCenterShowAudioIcon(enabled) {
        controlCenterShowAudioIcon = enabled
        saveSettings()
    }
    function setControlCenterWidgets(widgets) {
        controlCenterWidgets = widgets
        saveSettings()
    }

    function setBuckBarWidgetOrder(order) {
        buckBarWidgetOrder = order
        saveSettings()
    }

    function setBuckBarLeftWidgets(order) {
        buckBarLeftWidgets = order
        updateListModel(leftWidgetsModel, order)
        saveSettings()
    }

    function setBuckBarCenterWidgets(order) {
        buckBarCenterWidgets = order
        updateListModel(centerWidgetsModel, order)
        saveSettings()
    }

    function setBuckBarRightWidgets(order) {
        buckBarRightWidgets = order
        updateListModel(rightWidgetsModel, order)
        saveSettings()
    }

    function updateListModel(listModel, order) {
        listModel.clear()
        for (var i = 0; i < order.length; i++) {
            var widgetId = typeof order[i] === "string" ? order[i] : order[i].id
            var enabled = typeof order[i] === "string" ? true : order[i].enabled
            var size = typeof order[i] === "string" ? undefined : order[i].size
            var selectedGpuIndex = typeof order[i] === "string" ? undefined : order[i].selectedGpuIndex
            var pciId = typeof order[i] === "string" ? undefined : order[i].pciId
            var mountPath = typeof order[i] === "string" ? undefined : order[i].mountPath
            var item = {
                "widgetId": widgetId,
                "enabled": enabled
            }
            if (size !== undefined)
                item.size = size
            if (selectedGpuIndex !== undefined)
                item.selectedGpuIndex = selectedGpuIndex
            if (pciId !== undefined)
                item.pciId = pciId
            if (mountPath !== undefined)
                item.mountPath = mountPath

            listModel.append(item)
        }
        // Emit signal to notify widgets that data has changed
        widgetDataChanged()
    }

    function resetBuckBarWidgetsToDefault() {
        var defaultLeft = ["launcherButton", "workspaceSwitcher", "focusedWindow"]
        var defaultCenter = ["music", "clock", "weather"]
        var defaultRight = ["systemTray", "clipboard", "notificationButton", "battery", "controlCenterButton"]
        buckBarLeftWidgets = defaultLeft
        buckBarCenterWidgets = defaultCenter
        buckBarRightWidgets = defaultRight
        updateListModel(leftWidgetsModel, defaultLeft)
        updateListModel(centerWidgetsModel, defaultCenter)
        updateListModel(rightWidgetsModel, defaultRight)
        showLauncherButton = true
        showWorkspaceSwitcher = true
        showFocusedWindow = true
        showWeather = true
        showMusic = true
        showClipboard = true
        showCpuUsage = true
        showMemUsage = true
        showCpuTemp = true
        showGpuTemp = true
        showSystemTray = true
        showClock = true
        showNotificationButton = true
        showBattery = true
        showControlCenterButton = true
        saveSettings()
    }

    // View mode setters
    function setAppLauncherViewMode(mode) {
        appLauncherViewMode = mode
        saveSettings()
    }

    function setSpotlightModalViewMode(mode) {
        spotlightModalViewMode = mode
        saveSettings()
    }

    // Weather location setter
    function setWeatherLocation(displayName, coordinates) {
        weatherLocation = displayName
        weatherCoordinates = coordinates
        saveSettings()
    }

    function setAutoLocation(enabled) {
        useAutoLocation = enabled
        saveSettings()
    }

    function setWeatherEnabled(enabled) {
        weatherEnabled = enabled
        saveSettings()
    }

    // Network preference setter
    function setNetworkPreference(preference) {
        networkPreference = preference
        saveSettings()
    }

    function detectAvailableIconThemes() {
        // First detect system default, then available themes
        systemDefaultDetectionProcess.running = true
    }

    function detectQtTools() {
        qtToolsDetectionProcess.running = true
    }

    function setIconTheme(themeName) {
        iconTheme = themeName
        updateGtkIconTheme(themeName)
        updateQtIconTheme(themeName)
        saveSettings()
        if (typeof Theme !== "undefined" && Theme.currentTheme === Theme.dynamic)
            Theme.generateSystemThemes()
    }

    function updateGtkIconTheme(themeName) {
        var gtkThemeName = (themeName === "System Default") ? systemDefaultIconTheme : themeName
        if (gtkThemeName !== "System Default" && gtkThemeName !== "") {
            var script = "if command -v gsettings >/dev/null 2>&1 && gsettings list-schemas | grep -q org.gnome.desktop.interface; then\n"
                    + "    gsettings set org.gnome.desktop.interface icon-theme '" + gtkThemeName + "'\n" + "    echo 'Updated via gsettings'\n" + "elif command -v dconf >/dev/null 2>&1; then\n" + "    dconf write /org/gnome/desktop/interface/icon-theme \\\"" + gtkThemeName + "\\\"\n"
                    + "    echo 'Updated via dconf'\n" + "fi\n" + "\n" + "# Ensure config directories exist\n" + "mkdir -p " + _configDir + "/gtk-3.0 " + _configDir
                    + "/gtk-4.0\n" + "\n" + "# Update settings.ini files (keep existing gtk-theme-name)\n" + "for config_dir in " + _configDir + "/gtk-3.0 " + _configDir + "/gtk-4.0; do\n"
                    + "    settings_file=\"$config_dir/settings.ini\"\n" + "    if [ -f \"$settings_file\" ]; then\n" + "        # Update existing icon-theme-name line or add it\n" + "        if grep -q '^gtk-icon-theme-name=' \"$settings_file\"; then\n" + "            sed -i 's/^gtk-icon-theme-name=.*/gtk-icon-theme-name=" + gtkThemeName + "/' \"$settings_file\"\n" + "        else\n"
                    + "            # Add icon theme setting to [Settings] section or create it\n" + "            if grep -q '\\[Settings\\]' \"$settings_file\"; then\n" + "                sed -i '/\\[Settings\\]/a gtk-icon-theme-name=" + gtkThemeName + "' \"$settings_file\"\n" + "            else\n" + "                echo -e '\\n[Settings]\\ngtk-icon-theme-name=" + gtkThemeName
                    + "' >> \"$settings_file\"\n" + "            fi\n" + "        fi\n" + "    else\n" + "        # Create new settings.ini file\n" + "        echo -e '[Settings]\\ngtk-icon-theme-name=" + gtkThemeName + "' > \"$settings_file\"\n"
                    + "    fi\n" + "    echo \"Updated $settings_file\"\n" + "done\n" + "\n" + "# Clear icon cache and force refresh\n" + "rm -rf ~/.cache/icon-cache ~/.cache/thumbnails 2>/dev/null || true\n" + "# Send SIGHUP to running GTK applications to reload themes (Fedora-specific)\n" + "pkill -HUP -f 'gtk' 2>/dev/null || true\n"
            Quickshell.execDetached(["sh", "-lc", script])
        }
    }

    function updateQtIconTheme(themeName) {
        var qtThemeName = (themeName === "System Default") ? "" : themeName
        var home = _shq(Paths.strip(root._homeUrl))
        if (!qtThemeName) {
            // When "System Default" is selected, don't modify the config files at all
            // This preserves the user's existing qt6ct configuration
            return
        }
        var script = "mkdir -p " + _configDir + "/qt5ct " + _configDir + "/qt6ct " + _configDir + "/environment.d 2>/dev/null || true\n" + "update_qt_icon_theme() {\n" + "  local config_file=\"$1\"\n"
                + "  local theme_name=\"$2\"\n" + "  if [ -f \"$config_file\" ]; then\n" + "    if grep -q '^\\[Appearance\\]' \"$config_file\"; then\n" + "      if grep -q '^icon_theme=' \"$config_file\"; then\n" + "        sed -i \"s/^icon_theme=.*/icon_theme=$theme_name/\" \"$config_file\"\n" + "      else\n" + "        sed -i \"/^\\[Appearance\\]/a icon_theme=$theme_name\" \"$config_file\"\n" + "      fi\n"
                + "    else\n" + "      printf '\\n[Appearance]\\nicon_theme=%s\\n' \"$theme_name\" >> \"$config_file\"\n" + "    fi\n" + "  else\n" + "    printf '[Appearance]\\nicon_theme=%s\\n' \"$theme_name\" > \"$config_file\"\n" + "  fi\n" + "}\n" + "update_qt_icon_theme " + _configDir + "/qt5ct/qt5ct.conf " + _shq(
                    qtThemeName) + "\n" + "update_qt_icon_theme " + _configDir + "/qt6ct/qt6ct.conf " + _shq(qtThemeName) + "\n" + "rm -rf " + home + "/.cache/icon-cache " + home + "/.cache/thumbnails 2>/dev/null || true\n"
        Quickshell.execDetached(["sh", "-lc", script])
    }

    function applyStoredIconTheme() {
        updateGtkIconTheme(iconTheme)
        updateQtIconTheme(iconTheme)
    }

    function setUseOSLogo(enabled) {
        useOSLogo = enabled
        saveSettings()
    }

    function setOSLogoColorOverride(color) {
        osLogoColorOverride = color
        saveSettings()
    }

    function setOSLogoBrightness(brightness) {
        osLogoBrightness = brightness
        saveSettings()
    }

    function setOSLogoContrast(contrast) {
        osLogoContrast = contrast
        saveSettings()
    }

    function setFontFamily(family) {
        fontFamily = family
        saveSettings()
    }

    function setFontWeight(weight) {
        fontWeight = weight
        saveSettings()
    }

    function setMonoFontFamily(family) {
        monoFontFamily = family
        saveSettings()
    }

    function setFontScale(scale) {
        fontScale = scale
        saveSettings()
    }

    function setGtkThemingEnabled(enabled) {
        gtkThemingEnabled = enabled
        saveSettings()
        if (enabled && typeof Theme !== "undefined") {
            Theme.generateSystemThemesFromCurrentTheme()
        }
    }

    function setQtThemingEnabled(enabled) {
        qtThemingEnabled = enabled
        saveSettings()
        if (enabled && typeof Theme !== "undefined") {
            Theme.generateSystemThemesFromCurrentTheme()
        }
    }

    function setShowDock(enabled) {
        showDock = enabled
        if (enabled && dockPosition === buckBarPosition) {
            if (buckBarPosition === SettingsData.Position.Top) {
                setDockPosition(SettingsData.Position.Bottom)
                return
            }
            if (buckBarPosition === SettingsData.Position.Bottom) {
                setDockPosition(SettingsData.Position.Top)
                return
            }
            if (buckBarPosition === SettingsData.Position.Left) {
                setDockPosition(SettingsData.Position.Right)
                return
            }
            if (buckBarPosition === SettingsData.Position.Right) {
                setDockPosition(SettingsData.Position.Left)
                return
            }
        }
        saveSettings()
    }

    function setDockAutoHide(enabled) {
        dockAutoHide = enabled
        saveSettings()
    }

    function setDockGroupByApp(enabled) {
        dockGroupByApp = enabled
        saveSettings()
    }

    function setdockOpenOnOverview(enabled) {
        dockOpenOnOverview = enabled
        saveSettings()
    }

    function setCornerRadius(radius) {
        cornerRadius = radius
        saveSettings()
    }

    function setNotificationOverlayEnabled(enabled) {
        notificationOverlayEnabled = enabled
        saveSettings()
    }

    function setBuckBarAutoHide(enabled) {
        buckBarAutoHide = enabled
        saveSettings()
    }

    function setBuckBarOpenOnOverview(enabled) {
        buckBarOpenOnOverview = enabled
        saveSettings()
    }

    function setBuckBarVisible(visible) {
        buckBarVisible = visible
        saveSettings()
    }

    function toggleBuckBarVisible() {
        buckBarVisible = !buckBarVisible
        saveSettings()
    }

    function setNotificationTimeoutLow(timeout) {
        notificationTimeoutLow = timeout
        saveSettings()
    }

    function setNotificationTimeoutNormal(timeout) {
        notificationTimeoutNormal = timeout
        saveSettings()
    }

    function setNotificationTimeoutCritical(timeout) {
        notificationTimeoutCritical = timeout
        saveSettings()
    }

    function setNotificationPopupPosition(position) {
        notificationPopupPosition = position
        saveSettings()
    }

    function sendTestNotifications() {
        sendTestNotification(0)
        testNotifTimer1.start()
        testNotifTimer2.start()
    }

    function sendTestNotification(index) {
        const notifications = [
            ["Notification Position Test", "Dykwabi test notification 1 of 3 ~ Hi there!", "dialog-information"],
            ["Second Test", "Dykwabi Notification 2 of 3 ~ Check it out!", "emblem-default"],
            ["Third Test", "Dykwabi notification 3 of 3 ~ Enjoy!", "emblem-favorite"]
        ]

        if (index < 0 || index >= notifications.length) {
            return
        }

        const notif = notifications[index]
        testNotificationProcess.command = ["notify-send", "-h", "int:transient:1", "-a", "Dykwabi", "-i", notif[2], notif[0], notif[1]]
        testNotificationProcess.running = true
    }

    property Process testNotificationProcess

    testNotificationProcess: Process {
        command: []
        running: false
    }

    property Timer testNotifTimer1

    testNotifTimer1: Timer {
        interval: 400
        repeat: false
        onTriggered: sendTestNotification(1)
    }

    property Timer testNotifTimer2

    testNotifTimer2: Timer {
        interval: 800
        repeat: false
        onTriggered: sendTestNotification(2)
    }

    function setBuckBarSpacing(spacing) {
        buckBarSpacing = spacing
        saveSettings()
    }

    function setBuckBarBottomGap(gap) {
        buckBarBottomGap = gap
        saveSettings()
    }

    function setBuckBarInnerPadding(padding) {
        buckBarInnerPadding = padding
        saveSettings()
    }

    function setBuckBarSquareCorners(enabled) {
        buckBarSquareCorners = enabled
        saveSettings()
    }

    function setBuckBarNoBackground(enabled) {
        buckBarNoBackground = enabled
        saveSettings()
    }

    function setBuckBarGothCornersEnabled(enabled) {
        buckBarGothCornersEnabled = enabled
        saveSettings()
    }

    function setBuckBarPosition(position) {
        buckBarPosition = position
        if (position === SettingsData.Position.Bottom && dockPosition === SettingsData.Position.Bottom && showDock) {
            setDockPosition(SettingsData.Position.Top)
            return
        }
        if (position === SettingsData.Position.Top && dockPosition === SettingsData.Position.Top && showDock) {
            setDockPosition(SettingsData.Position.Bottom)
            return
        }
        if (position === SettingsData.Position.Left && dockPosition === SettingsData.Position.Left && showDock) {
            setDockPosition(SettingsData.Position.Right)
            return
        }
        if (position === SettingsData.Position.Right && dockPosition === SettingsData.Position.Right && showDock) {
            setDockPosition(SettingsData.Position.Left)
            return
        }
        saveSettings()
    }

    function setDockPosition(position) {
        dockPosition = position
        if (position === SettingsData.Position.Bottom && buckBarPosition === SettingsData.Position.Bottom && showDock) {
            setBuckBarPosition(SettingsData.Position.Top)
        }
        if (position === SettingsData.Position.Top && buckBarPosition === SettingsData.Position.Top && showDock) {
            setBuckBarPosition(SettingsData.Position.Bottom)
        }
        if (position === SettingsData.Position.Left && buckBarPosition === SettingsData.Position.Left && showDock) {
            setBuckBarPosition(SettingsData.Position.Right)
        }
        if (position === SettingsData.Position.Right && buckBarPosition === SettingsData.Position.Right && showDock) {
            setBuckBarPosition(SettingsData.Position.Left)
        }
        saveSettings()
        Qt.callLater(() => forceDockLayoutRefresh())
    }
    function setDockSpacing(spacing) {
        dockSpacing = spacing
        saveSettings()
    }
    function setDockBottomGap(gap) {
        dockBottomGap = gap
        saveSettings()
    }
    function setDockOpenOnOverview(enabled) {
        dockOpenOnOverview = enabled
        saveSettings()
    }

    function getPopupYPosition(barHeight) {
        const gothOffset = buckBarGothCornersEnabled ? Theme.cornerRadius : 0
        return barHeight + buckBarSpacing + buckBarBottomGap - gothOffset + Theme.popupDistance
    }

    function getPopupTriggerPosition(globalPos, screen, barThickness, widgetWidth) {
        const screenX = screen ? screen.x : 0
        const screenY = screen ? screen.y : 0
        const relativeX = globalPos.x - screenX
        const relativeY = globalPos.y - screenY

        if (buckBarPosition === SettingsData.Position.Left || buckBarPosition === SettingsData.Position.Right) {
            return {
                x: relativeY,
                y: barThickness + buckBarSpacing + Theme.popupDistance,
                width: widgetWidth
            }
        }
        return {
            x: relativeX,
            y: barThickness + buckBarSpacing + buckBarBottomGap + Theme.popupDistance,
            width: widgetWidth
        }
    }

    function setLockScreenShowPowerActions(enabled) {
        lockScreenShowPowerActions = enabled
        saveSettings()
    }

    function setHideBrightnessSlider(enabled) {
        hideBrightnessSlider = enabled
        saveSettings()
    }

    function setWidgetBackgroundColor(color) {
        widgetBackgroundColor = color
        saveSettings()
    }

    function setSurfaceBase(base) {
        surfaceBase = base
        saveSettings()
        if (typeof Theme !== "undefined") {
            Theme.generateSystemThemesFromCurrentTheme()
        }
    }

    function setScreenPreferences(prefs) {
        screenPreferences = prefs
        saveSettings()
    }

    function getFilteredScreens(componentId) {
        var prefs = screenPreferences && screenPreferences[componentId] || ["all"]
        if (prefs.includes("all")) {
            return Quickshell.screens
        }
        return Quickshell.screens.filter(screen => prefs.includes(screen.name))
    }

    // Plugin settings functions
    function getPluginSetting(pluginId, key, defaultValue) {
        if (!pluginSettings[pluginId]) {
            return defaultValue
        }
        return pluginSettings[pluginId][key] !== undefined ? pluginSettings[pluginId][key] : defaultValue
    }

    function setPluginSetting(pluginId, key, value) {
        if (!pluginSettings[pluginId]) {
            pluginSettings[pluginId] = {}
        }
        pluginSettings[pluginId][key] = value
        saveSettings()
    }

    function removePluginSettings(pluginId) {
        if (pluginSettings[pluginId]) {
            delete pluginSettings[pluginId]
            saveSettings()
        }
    }

    function getPluginSettingsForPlugin(pluginId) {
        return pluginSettings[pluginId] || {}
    }

    function setAnimationSpeed(speed) {
        animationSpeed = speed
        saveSettings()
    }

    function _shq(s) {
        return "'" + String(s).replace(/'/g, "'\\''") + "'"
    }

    Component.onCompleted: {
        if (!isGreeterMode) {
            loadSettings()
            fontCheckTimer.start()
            initializeListModels()
        }
    }

    ListModel {
        id: leftWidgetsModel
    }

    ListModel {
        id: centerWidgetsModel
    }

    ListModel {
        id: rightWidgetsModel
    }

    Timer {
        id: fontCheckTimer

        interval: 3000
        repeat: false
        onTriggered: {
            var availableFonts = Qt.fontFamilies()
            var missingFonts = []
            if (fontFamily === defaultFontFamily && !availableFonts.includes(defaultFontFamily))
            missingFonts.push(defaultFontFamily)

            if (monoFontFamily === defaultMonoFontFamily && !availableFonts.includes(defaultMonoFontFamily))
            missingFonts.push(defaultMonoFontFamily)

            if (missingFonts.length > 0) {
                var message = "Missing fonts: " + missingFonts.join(", ") + ". Using system defaults."
                ToastService.showWarning(message)
            }
        }
    }

    property bool hasTriedDefaultSettings: false

    FileView {
        id: settingsFile

        path: isGreeterMode ? "" : StandardPaths.writableLocation(StandardPaths.ConfigLocation) + "/BuckMaterialShell/settings.json"
        blockLoading: true
        blockWrites: true
        atomicWrites: true
        watchChanges: !isGreeterMode
        onLoaded: {
            if (!isGreeterMode) {
                parseSettings(settingsFile.text())
                hasTriedDefaultSettings = false
            }
        }
        onLoadFailed: error => {
            if (!isGreeterMode && !hasTriedDefaultSettings) {
                hasTriedDefaultSettings = true
                defaultSettingsCheckProcess.running = true
            } else if (!isGreeterMode) {
                applyStoredTheme()
            }
        }
    }

    Process {
        id: systemDefaultDetectionProcess

        command: ["sh", "-c", "gsettings get org.gnome.desktop.interface icon-theme 2>/dev/null | sed \"s/'//g\" || echo ''"]
        running: false
        onExited: exitCode => {
            if (exitCode === 0 && stdout && stdout.length > 0)
            systemDefaultIconTheme = stdout.trim()
            else
            systemDefaultIconTheme = ""
            iconThemeDetectionProcess.running = true
        }
    }

    Process {
        id: iconThemeDetectionProcess

        command: ["sh", "-c", "find /usr/share/icons ~/.local/share/icons ~/.icons -maxdepth 1 -type d 2>/dev/null | sed 's|.*/||' | grep -v '^icons$' | sort -u"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                var detectedThemes = ["System Default"]
                if (text && text.trim()) {
                    var themes = text.trim().split('\n')
                    for (var i = 0; i < themes.length; i++) {
                        var theme = themes[i].trim()
                        if (theme && theme !== "" && theme !== "default" && theme !== "hicolor" && theme !== "locolor")
                        detectedThemes.push(theme)
                    }
                }
                availableIconThemes = detectedThemes
            }
        }
    }

    Process {
        id: qtToolsDetectionProcess

        command: ["sh", "-c", "echo -n 'qt5ct:'; command -v qt5ct >/dev/null && echo 'true' || echo 'false'; echo -n 'qt6ct:'; command -v qt6ct >/dev/null && echo 'true' || echo 'false'; echo -n 'gtk:'; (command -v gsettings >/dev/null || command -v dconf >/dev/null) && echo 'true' || echo 'false'"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                if (text && text.trim()) {
                    var lines = text.trim().split('\n')
                    for (var i = 0; i < lines.length; i++) {
                        var line = lines[i]
                        if (line.startsWith('qt5ct:'))
                        qt5ctAvailable = line.split(':')[1] === 'true'
                        else if (line.startsWith('qt6ct:'))
                        qt6ctAvailable = line.split(':')[1] === 'true'
                        else if (line.startsWith('gtk:'))
                        gtkAvailable = line.split(':')[1] === 'true'
                    }
                }
            }
        }
    }

    Process {
        id: defaultSettingsCheckProcess

        command: ["sh", "-c", "CONFIG_DIR=\"" + _configDir
            + "/BuckMaterialShell\"; if [ -f \"$CONFIG_DIR/default-settings.json\" ] && [ ! -f \"$CONFIG_DIR/settings.json\" ]; then cp \"$CONFIG_DIR/default-settings.json\" \"$CONFIG_DIR/settings.json\" && echo 'copied'; else echo 'not_found'; fi"]
        running: false
        onExited: exitCode => {
            if (exitCode === 0) {
                console.log("Copied default-settings.json to settings.json")
                settingsFile.reload()
            } else {
                // No default settings file found, just apply stored theme
                applyStoredTheme()
            }
        }
    }

    IpcHandler {
        function reveal(): string {
            root.setBuckBarVisible(true)
            return "BAR_SHOW_SUCCESS"
        }

        function hide(): string {
            root.setBuckBarVisible(false)
            return "BAR_HIDE_SUCCESS"
        }

        function toggle(): string {
            root.toggleBuckBarVisible()
            return root.buckBarVisible ? "BAR_SHOW_SUCCESS" : "BAR_HIDE_SUCCESS"
        }

        function status(): string {
            return root.buckBarVisible ? "visible" : "hidden"
        }

        target: "bar"
    }
}
