import QtQuick
import Quickshell

ShellRoot {
    id: entrypoint

    readonly property bool runGreeter: Quickshell.env("DYKWABI_RUN_GREETER") === "1" || Quickshell.env("DYKWABI_RUN_GREETER") === "true"

    Loader {
        id: dykwabiShellLoader
        asynchronous: false
        sourceComponent: DykwabiShell{}
        active: !entrypoint.runGreeter
    }

    Loader {
        id: dykwabiGreeterLoader
        asynchronous: false
        sourceComponent: DykwabiGreeter{}
        active: entrypoint.runGreeter
    }
}
