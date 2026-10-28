import QtQuick
import Quickshell
import qs.config

FloatingWindow {
    id: root

    title: "Collected Words"
    implicitWidth: 472
    implicitHeight: Math.max(407, view.implicitHeight)
    minimumSize: Qt.size(472, 407)
    visible: true
    color: "transparent"

    CollectedWordsView {
        id: view
        anchors.fill: parent
    }
}

