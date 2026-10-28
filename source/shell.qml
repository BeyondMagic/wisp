import QtQuick
import Quickshell
import qs.modules.login
import qs.modules.collected_words

ShellRoot {
    id: root

    readonly property string activeModule: Quickshell.env("WISP_MODULE") || "login"

    Loader {
        active: root.activeModule === "login"
        sourceComponent: LoginWindow {}
    }

    Loader {
        active: root.activeModule === "collected-words"
        sourceComponent: CollectedWordsWindow {}
    }
}

