import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import qs.Common
import qs.Modules.Plugins
import qs.Services
import qs.Widgets

BasePill {
    id: root

    property bool isActive: false
    property var hyprlandOverviewLoader: null

    content: Component {
        Item {
            implicitWidth: root.widgetThickness - root.horizontalPadding * 2
            implicitHeight: root.widgetThickness - root.horizontalPadding * 2

            BuckIcon {
                visible: SettingsData.launcherLogoMode === "apps"
                anchors.centerIn: parent
                name: "apps"
                size: Theme.barIconSize(root.barThickness, -4)
                color: Theme.surfaceText
            }

            SystemLogo {
                visible: SettingsData.launcherLogoMode === "os"
                anchors.centerIn: parent
                width: Theme.barIconSize(root.barThickness, SettingsData.launcherLogoSizeOffset)
                height: Theme.barIconSize(root.barThickness, SettingsData.launcherLogoSizeOffset)
                colorOverride: Theme.effectiveLogoColor
                brightnessOverride: SettingsData.launcherLogoBrightness
                contrastOverride: SettingsData.launcherLogoContrast
            }

            IconImage {
                visible: SettingsData.launcherLogoMode === "buck"
                anchors.centerIn: parent
                width: Theme.barIconSize(root.barThickness, SettingsData.launcherLogoSizeOffset)
                height: Theme.barIconSize(root.barThickness, SettingsData.launcherLogoSizeOffset)
                smooth: true
                mipmap: true
                asynchronous: true
                source: "file://" + Theme.shellDir + "/assets/bucklogo.svg"
                layer.enabled: Theme.effectiveLogoColor !== ""
                layer.smooth: true
                layer.mipmap: true
                layer.effect: MultiEffect {
                    saturation: 0
                    colorization: 1
                    colorizationColor: Theme.effectiveLogoColor
                }
            }

            IconImage {
                visible: SettingsData.launcherLogoMode === "compositor" && (CompositorService.isNiri || CompositorService.isHyprland || CompositorService.isDwl || CompositorService.isSway)
                anchors.centerIn: parent
                width: Theme.barIconSize(root.barThickness, SettingsData.launcherLogoSizeOffset)
                height: Theme.barIconSize(root.barThickness, SettingsData.launcherLogoSizeOffset)
                smooth: true
                asynchronous: true
                source: {
                    if (CompositorService.isNiri) {
                        return "file://" + Theme.shellDir + "/assets/niri.svg"
                    } else if (CompositorService.isHyprland) {
                        return "file://" + Theme.shellDir + "/assets/hyprland.svg"
                    } else if (CompositorService.isDwl) {
                        return "file://" + Theme.shellDir + "/assets/mango.png"
                    } else if (CompositorService.isSway) {
                        return "file://" + Theme.shellDir + "/assets/sway.svg"
                    }
                    return ""
                }
                layer.enabled: Theme.effectiveLogoColor !== ""
                layer.effect: MultiEffect {
                    saturation: 0
                    colorization: 1
                    colorizationColor: Theme.effectiveLogoColor
                    brightness: {
                        SettingsData.launcherLogoBrightness
                    }
                    contrast: {
                        SettingsData.launcherLogoContrast
                    }
                }
            }

            IconImage {
                visible: SettingsData.launcherLogoMode === "custom" && SettingsData.launcherLogoCustomPath !== ""
                anchors.centerIn: parent
                width: Theme.barIconSize(root.barThickness, SettingsData.launcherLogoSizeOffset)
                height: Theme.barIconSize(root.barThickness, SettingsData.launcherLogoSizeOffset)
                smooth: true
                asynchronous: true
                source: SettingsData.launcherLogoCustomPath ? "file://" + SettingsData.launcherLogoCustomPath.replace("file://", "") : ""
                layer.enabled: Theme.effectiveLogoColor !== ""
                layer.effect: MultiEffect {
                    saturation: 0
                    colorization: 1
                    colorizationColor: Theme.effectiveLogoColor
                    brightness: SettingsData.launcherLogoBrightness
                    contrast: SettingsData.launcherLogoContrast
                }
            }
        }
    }

    MouseArea {
        id: customMouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.RightButton
        onPressed: function (mouse){
            if (CompositorService.isNiri) {
                NiriService.toggleOverview()
            } else if (root.hyprlandOverviewLoader?.item) {
                root.hyprlandOverviewLoader.item.overviewOpen = !root.hyprlandOverviewLoader.item.overviewOpen
            }
        }
    }
}
