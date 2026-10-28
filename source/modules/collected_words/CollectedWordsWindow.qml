import QtQuick
import Quickshell
import qs.config

FloatingWindow {
    id: root

    readonly property int targetHeight: Math.max(407, view.implicitHeight)

    title: "Collected Words"
    implicitWidth: 472
    implicitHeight: targetHeight
    minimumSize: Qt.size(472, targetHeight)
    maximumSize: Qt.size(472, targetHeight)
    visible: true
    color: "transparent"

    CollectedWordsView {
        id: view
        anchors.fill: parent
    }
}
