import QtQuick
import qs.config
import qs.services
import qs.utils

Item {
    id: root

    readonly property string stateName: FingerprintService.state
    property real revealProgress: 0.0

    implicitWidth: 36
    implicitHeight: 36
    width: 36
    height: 36

    onStateNameChanged: {
        if (stateName === "Scanning") {
            scanningLoop.restart();
        } else {
            scanningLoop.stop();
            if (stateName === "Filled") {
                fillCompleteAnim.restart();
            } else {
                revealProgress = 0.0;
            }
        }
    }

    Component.onCompleted: {
        if (stateName === "Scanning") {
            scanningLoop.start();
        }
    }

    // Bottom-to-top green reveal motion during "Scanning"
    SequentialAnimation {
        id: scanningLoop
        loops: Animation.Infinite
        running: false

        PropertyAction {
            target: root
            property: "revealProgress"
            value: 0.0
        }
        NumberAnimation {
            target: root
            property: "revealProgress"
            from: 0.0
            to: 1.0
            duration: 1100
            easing.type: Easing.InOutCubic
        }
        PauseAnimation {
            duration: 200
        }
        NumberAnimation {
            target: root
            property: "revealProgress"
            from: 1.0
            to: 0.0
            duration: 650
            easing.type: Easing.InOutQuad
        }
        PauseAnimation {
            duration: 150
        }
    }

    NumberAnimation {
        id: fillCompleteAnim
        target: root
        property: "revealProgress"
        to: 1.0
        duration: 220
        easing.type: Easing.OutCubic
    }

    // Base button box (36x36, cornerRadius 5, 1px inside stroke)
    Rectangle {
        id: baseBox
        anchors.fill: parent
        radius: 5
        color: "transparent"
        border.width: 1
        border.color: root.stateName === "Not recognized" ? Theme.statusWarning : Theme.borderButton

        Behavior on border.color {
            ColorAnimation { duration: 160 }
        }

        Image {
            x: 6
            y: 6
            width: 24
            height: 24
            sourceSize: Qt.size(48, 48)
            fillMode: Image.PreserveAspectFit
            source: {
                if (root.stateName === "Not recognized")
                    return Icons.dataUri(Icons.fingerprint("#E5C07B"));
                if (root.stateName === "Filled")
                    return Icons.dataUri(Icons.fingerprint("#4AC26B"));
                return Icons.dataUri(Icons.fingerprint("#FAFAFA"));
            }
        }
    }

    // Node 147:177: Bottom-to-top clipped reveal with counter-translation
    Item {
        id: clippedViewport
        visible: root.stateName === "Scanning" || root.stateName === "Filled"
        x: 0
        y: parent.height - height
        width: 36
        height: Math.round(root.revealProgress * 36)
        clip: true

        Item {
            x: 0
            y: -(36 - clippedViewport.height)
            width: 36
            height: 36

            Image {
                x: 6
                y: 6
                width: 24
                height: 24
                sourceSize: Qt.size(48, 48)
                fillMode: Image.PreserveAspectFit
                source: Icons.dataUri(Icons.fingerprint("#4AC26B"))
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            FingerprintService.startScanning();
        }
    }
}

