import QtQuick

Item {
    id: root

    property Item targetItem: parent
    property real intensity: 8

    Translate {
        id: shakeTranslate
        x: 0
    }

    Component.onCompleted: {
        if (targetItem) {
            targetItem.transform.push(shakeTranslate);
        }
    }

    SequentialAnimation {
        id: anim
        NumberAnimation { target: shakeTranslate; property: "x"; to: -root.intensity; duration: 45; easing.type: Easing.OutQuad }
        NumberAnimation { target: shakeTranslate; property: "x"; to: root.intensity;  duration: 55; easing.type: Easing.InOutQuad }
        NumberAnimation { target: shakeTranslate; property: "x"; to: -root.intensity * 0.75; duration: 55; easing.type: Easing.InOutQuad }
        NumberAnimation { target: shakeTranslate; property: "x"; to: root.intensity * 0.75;  duration: 55; easing.type: Easing.InOutQuad }
        NumberAnimation { target: shakeTranslate; property: "x"; to: -root.intensity * 0.35; duration: 45; easing.type: Easing.InOutQuad }
        NumberAnimation { target: shakeTranslate; property: "x"; to: 0; duration: 45; easing.type: Easing.InQuad }
    }

    function trigger() {
        anim.restart();
    }
}

