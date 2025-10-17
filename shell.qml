//@ pragma Env QSG_RENDER_LOOP=threaded
//@ pragma Env QT_MEDIA_BACKEND=ffmpeg
//@ pragma Env QT_FFMPEG_DECODING_HW_DEVICE_TYPES=vaapi
//@ pragma Env QT_FFMPEG_ENCODING_HW_DEVICE_TYPES=vaapi
//@ pragma UseQApplication

import QtQuick
import Quickshell

ShellRoot {
    id: entrypoint

    readonly property bool runGreeter: Quickshell.env("DYKWABI_RUN_GREETER") === "1" || Quickshell.env("DYKWABI_RUN_GREETER") === "true"

    Loader {
        id: dykwabiShellLoader
        asynchronous: false
        sourceComponent: DykwabiShell {}
        active: !entrypoint.runGreeter
    }

    Loader {
        id: dykwabiGreeterLoader
        asynchronous: false
        sourceComponent: DykwabiGreeter {}
        active: entrypoint.runGreeter
    }
}
