import Quickshell
import QtQuick

FloatingWindow {
    width: 200
    height: 100
    visible: true
    color: "#222222"

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Text {
        anchors.centerIn: parent
        text: Qt.formatDateTime(clock.date, "hh:mm:ss")
        color: "white"
        font.pixelSize: 24
    }

}