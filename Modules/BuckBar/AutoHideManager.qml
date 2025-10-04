import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Common
import qs.Services

Item {
    id: root

    required property var barWindow
    required property var axis
    required property var appDrawerLoader
    required property var buckDashPopoutLoader
    required property var processListPopoutLoader
    required property var notificationCenterLoader
    required property var batteryPopoutLoader
    required property var vpnPopoutLoader
    required property var controlCenterLoader
    required property var clipboardHistoryModalPopup
    required property var systemUpdateLoader
    required property var notepadInstance

    property alias reveal: core.reveal
    property alias autoHide: core.autoHide
    property alias backgroundTransparency: core.backgroundTransparency
    property alias hasActivePopout: core.hasActivePopout
    property alias mouseArea: topBarMouseArea

    Item {
        id: inputMask

        readonly property int barThickness: barWindow.px(barWindow.effectiveBarThickness + SettingsData.buckBarSpacing)

        readonly property bool showing: SettingsData.buckBarVisible && (core.reveal
                                 || (CompositorService.isNiri && NiriService.inOverview && SettingsData.buckBarOpenOnOverview)
                                 || !core.autoHide)

        readonly property int maskThickness: showing ? barThickness : 1

        x: {
            if (!axis.isVertical) {
                return 0
            } else {
                switch (SettingsData.buckBarPosition) {
                case SettingsData.Position.Left:  return 0
                case SettingsData.Position.Right: return parent.width - maskThickness
                default: return 0
                }
            }
        }
        y: {
            if (axis.isVertical) {
                return 0
            } else {
                switch (SettingsData.buckBarPosition) {
                case SettingsData.Position.Top:    return 0
                case SettingsData.Position.Bottom: return parent.height - maskThickness
                default: return 0
                }
            }
        }
        width: axis.isVertical ? maskThickness : parent.width
        height: axis.isVertical ? parent.height : maskThickness
    }

    Region {
        id: mask
        item: inputMask
    }

    property alias maskRegion: mask

    QtObject {
        id: core

        property real backgroundTransparency: SettingsData.buckBarTransparency
        property bool autoHide: SettingsData.buckBarAutoHide
        property bool revealSticky: false

        property bool notepadInstanceVisible: notepadInstance?.isVisible ?? false

        readonly property bool hasActivePopout: {
            const loaders = [{
                                 "loader": appDrawerLoader,
                                 "prop": "shouldBeVisible"
                             }, {
                                 "loader": buckDashPopoutLoader,
                                 "prop": "shouldBeVisible"
                             }, {
                                 "loader": processListPopoutLoader,
                                 "prop": "shouldBeVisible"
                             }, {
                                 "loader": notificationCenterLoader,
                                 "prop": "shouldBeVisible"
                             }, {
                                 "loader": batteryPopoutLoader,
                                 "prop": "shouldBeVisible"
                             }, {
                                 "loader": vpnPopoutLoader,
                                 "prop": "shouldBeVisible"
                             }, {
                                 "loader": controlCenterLoader,
                                 "prop": "shouldBeVisible"
                             }, {
                                 "loader": clipboardHistoryModalPopup,
                                 "prop": "visible"
                             }, {
                                 "loader": systemUpdateLoader,
                                 "prop": "shouldBeVisible"
                             }]
            return notepadInstanceVisible || loaders.some(item => {
                if (item.loader) {
                    return item.loader?.item?.[item.prop]
                }
                return false
            })
        }

        property bool reveal: {
            if (CompositorService.isNiri && NiriService.inOverview) {
                return SettingsData.buckBarOpenOnOverview
            }
            return SettingsData.buckBarVisible && (!autoHide || topBarMouseArea.containsMouse || hasActivePopout || revealSticky)
        }

        onHasActivePopoutChanged: {
            if (!hasActivePopout && autoHide && !topBarMouseArea.containsMouse) {
                revealSticky = true
                revealHold.restart()
            }
        }
    }

    Timer {
        id: revealHold
        interval: 250
        repeat: false
        onTriggered: core.revealSticky = false
    }

    Connections {
        function onBuckBarTransparencyChanged() {
            core.backgroundTransparency = SettingsData.buckBarTransparency
        }

        target: SettingsData
    }

    Connections {
        target: topBarMouseArea
        function onContainsMouseChanged() {
            if (topBarMouseArea.containsMouse) {
                core.revealSticky = true
                revealHold.stop()
            } else {
                if (core.autoHide && !core.hasActivePopout) {
                    revealHold.restart()
                }
            }
        }
    }

    MouseArea {
        id: topBarMouseArea
        y: !barWindow.isVertical ? (SettingsData.buckBarPosition === SettingsData.Position.Bottom ? parent.height - height : 0) : 0
        x: barWindow.isVertical ? (SettingsData.buckBarPosition === SettingsData.Position.Right ? parent.width - width : 0) : 0
        height: !barWindow.isVertical ? barWindow.px(barWindow.effectiveBarThickness + SettingsData.buckBarSpacing) : undefined
        width: barWindow.isVertical ? barWindow.px(barWindow.effectiveBarThickness + SettingsData.buckBarSpacing) : undefined
        anchors {
            left: !barWindow.isVertical ? parent.left : (SettingsData.buckBarPosition === SettingsData.Position.Left ? parent.left : undefined)
            right: !barWindow.isVertical ? parent.right : (SettingsData.buckBarPosition === SettingsData.Position.Right ? parent.right : undefined)
            top: barWindow.isVertical ? parent.top : undefined
            bottom: barWindow.isVertical ? parent.bottom : undefined
        }
        hoverEnabled: SettingsData.buckBarAutoHide && !core.reveal
        acceptedButtons: Qt.NoButton
        enabled: SettingsData.buckBarAutoHide && !core.reveal
    }
}