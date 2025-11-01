import QtQuick
import qs.Common

Item {
    id: root

    anchors.fill: parent

    property string screenName: ""
    property bool isColorWallpaper: {
        var currentWallpaper = SessionData.getMonitorWallpaper(screenName)
        return currentWallpaper && currentWallpaper.startsWith("#")
    }

    Rectangle {
        anchors.fill: parent
        color: isColorWallpaper ? SessionData.getMonitorWallpaper(screenName) : Theme.background
    }

    Rectangle {
        x: parent.width * 0.7
        y: -parent.height * 0.3
        width: parent.width * 0.8
        height: parent.height * 1.5
        color: Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.15)
        rotation: 35
        visible: !isColorWallpaper
    }

    Rectangle {
        x: parent.width * 0.85
        y: -parent.height * 0.2
        width: parent.width * 0.4
        height: parent.height * 1.2
        color: Qt.rgba(Theme.secondary.r, Theme.secondary.g, Theme.secondary.b, 0.12)
        rotation: 35
        visible: !isColorWallpaper
    }
}
