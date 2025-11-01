import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Io
import qs.Common
import qs.Widgets
import qs.Modules

Variants {
    model: {
        if (SessionData.isGreeterMode) {
            return Quickshell.screens
        }
        return SettingsData.getFilteredScreens("wallpaper")
    }

    PanelWindow {
        id: blurWallpaperWindow

        required property var modelData

        screen: modelData

        WlrLayershell.layer: WlrLayer.Background
        WlrLayershell.namespace: "dykwabi:blurwallpaper"
        WlrLayershell.exclusionMode: ExclusionMode.Ignore

        anchors.top: true
        anchors.bottom: true
        anchors.left: true
        anchors.right: true

        color: "transparent"

        Item {
            id: root
            anchors.fill: parent

            property string source: SessionData.getMonitorWallpaper(modelData.name) || ""
            property bool isColorSource: source.startsWith("#")

            Connections {
                target: SessionData
                function onIsLightModeChanged() {
                    if (SessionData.perModeWallpaper) {
                        var newSource = SessionData.getMonitorWallpaper(modelData.name) || ""
                        if (newSource !== root.source) {
                            root.source = newSource
                        }
                    }
                }
            }

            function getFillMode(modeName) {
                switch (modeName) {
                case "Stretch":
                    return Image.Stretch
                case "Fit":
                case "PreserveAspectFit":
                    return Image.PreserveAspectFit
                case "Fill":
                case "PreserveAspectCrop":
                    return Image.PreserveAspectCrop
                case "Tile":
                    return Image.Tile
                case "TileVertically":
                    return Image.TileVertically
                case "TileHorizontally":
                    return Image.TileHorizontally
                case "Pad":
                    return Image.Pad
                default:
                    return Image.PreserveAspectCrop
                }
            }

            WallpaperEngineProc {
                id: weProc
                monitor: modelData.name
            }

            Component.onCompleted: {
                if (source) {
                    const formattedSource = source.startsWith("file://") ? source : "file://" + source
                    setWallpaperImmediate(formattedSource)
                }
                isInitialized = true
            }

            Component.onDestruction: {
                weProc.stop()
            }

            property bool isInitialized: false
            property real transitionProgress: 0
            readonly property bool transitioning: transitionAnimation.running

            onSourceChanged: {
                const isWE = source.startsWith("we:")
                const isColor = source.startsWith("#")

                if (isWE) {
                    setWallpaperImmediate("")
                    weProc.start(source.substring(3))
                } else {
                    weProc.stop()
                    if (!source) {
                        setWallpaperImmediate("")
                    } else if (isColor) {
                        setWallpaperImmediate("")
                    } else {
                        if (!isInitialized || !currentWallpaper.source) {
                            setWallpaperImmediate(source.startsWith("file://") ? source : "file://" + source)
                            isInitialized = true
                        } else {
                            changeWallpaper(source.startsWith("file://") ? source : "file://" + source)
                        }
                    }
                }
            }

            function setWallpaperImmediate(newSource) {
                transitionAnimation.stop()
                root.transitionProgress = 0.0
                currentWallpaper.source = newSource
                nextWallpaper.source = ""
                currentWallpaper.opacity = 1
                nextWallpaper.opacity = 0
            }

            function changeWallpaper(newPath) {
                if (newPath === currentWallpaper.source)
                    return
                if (!newPath || newPath.startsWith("#"))
                    return

                if (root.transitioning) {
                    transitionAnimation.stop()
                    root.transitionProgress = 0
                    currentWallpaper.source = nextWallpaper.source
                    nextWallpaper.source = ""
                }

                if (!currentWallpaper.source) {
                    setWallpaperImmediate(newPath)
                    return
                }

                nextWallpaper.source = newPath

                if (nextWallpaper.status === Image.Ready) {
                    transitionAnimation.start()
                }
            }

            Loader {
                anchors.fill: parent
                active: !root.source || root.isColorSource
                asynchronous: true

                sourceComponent: BuckBackdrop {
                    screenName: modelData.name
                }
            }

            Image {
                id: currentWallpaper
                anchors.fill: parent
                visible: false
                opacity: 1
                asynchronous: true
                smooth: true
                cache: true
                fillMode: root.getFillMode(SettingsData.wallpaperFillMode)
            }

            Image {
                id: nextWallpaper
                anchors.fill: parent
                visible: false
                opacity: 0
                asynchronous: true
                smooth: true
                cache: true
                fillMode: root.getFillMode(SettingsData.wallpaperFillMode)

                onStatusChanged: {
                    if (status !== Image.Ready)
                        return

                    if (!root.transitioning) {
                        transitionAnimation.start()
                    }
                }
            }

            Item {
                id: blurredLayer
                anchors.fill: parent

                MultiEffect {
                    anchors.fill: parent
                    source: currentWallpaper
                    blurEnabled: true
                    blur: 0.8
                    blurMax: 75
                    opacity: 1 - root.transitionProgress
                }

                MultiEffect {
                    anchors.fill: parent
                    source: nextWallpaper
                    blurEnabled: true
                    blur: 0.8
                    blurMax: 75
                    opacity: root.transitionProgress
                }
            }

            NumberAnimation {
                id: transitionAnimation
                target: root
                property: "transitionProgress"
                from: 0.0
                to: 1.0
                duration: 1000
                easing.type: Easing.InOutCubic
                onFinished: {
                    Qt.callLater(() => {
                                     if (nextWallpaper.source && nextWallpaper.status === Image.Ready && !nextWallpaper.source.toString().startsWith("#")) {
                                         currentWallpaper.source = nextWallpaper.source
                                     }
                                     nextWallpaper.source = ""
                                     currentWallpaper.opacity = 1
                                     nextWallpaper.opacity = 0
                                     root.transitionProgress = 0.0
                                 })
                }
            }
        }
    }
}
