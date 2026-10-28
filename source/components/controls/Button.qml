import QtQuick
import QtQuick.Layouts
import qs.config
import qs.utils

Rectangle {
    id: root

    property string text: ""
    property string iconSvg: ""
    property string variant: "primary" // "primary" | "secondary" | "outline" | "icon" | "destructive"
    property bool loading: false
    property alias cursorShape: mouseArea.cursorShape
    property int paddingHorizontal: 16
    property int paddingVertical: 10
    property int radiusSize: 0

    activeFocusOnTab: true

    signal clicked()
    signal navigateUp()
    signal navigateDown()
    signal navigateLeft()
    signal navigateRight()
    signal navigateNext()
    signal navigatePrev()

    implicitWidth: Math.max(36, contentRow.implicitWidth + (paddingHorizontal * 2))
    implicitHeight: Math.max(36, contentRow.implicitHeight + (paddingVertical * 2))

    radius: radiusSize

    color: {
        if (!enabled)
            return Qt.rgba(Theme.borderButton.r, Theme.borderButton.g, Theme.borderButton.b, 0.05);
        if (variant === "primary") {
            return mouseArea.pressed ? Qt.darker(Theme.actionPrimaryBg, 1.15)
                 : (mouseArea.containsMouse ? Qt.lighter(Theme.actionPrimaryBg, 1.1) : Theme.actionPrimaryBg);
        }
        if (variant === "destructive") {
            return mouseArea.pressed
                ? Qt.rgba(Theme.statusError.r, Theme.statusError.g, Theme.statusError.b, 0.35)
                : (mouseArea.containsMouse
                    ? Qt.rgba(Theme.statusError.r, Theme.statusError.g, Theme.statusError.b, 0.30)
                    : Qt.rgba(Theme.statusError.r, Theme.statusError.g, Theme.statusError.b, 0.25));
        }
        if (variant === "secondary" || variant === "icon") {
            return mouseArea.pressed ? Qt.rgba(Theme.textPrimary.r, Theme.textPrimary.g, Theme.textPrimary.b, 0.15)
                 : (mouseArea.containsMouse ? Qt.rgba(Theme.textPrimary.r, Theme.textPrimary.g, Theme.textPrimary.b, 0.08) : "transparent");
        }
        return "transparent";
    }

    border.width: root.activeFocus ? 1.5 : ((variant === "outline" || variant === "secondary") ? 1 : 0)
    border.color: root.activeFocus ? Theme.borderFocus : Theme.borderButton

    Behavior on color {
        ColorAnimation { duration: 120 }
    }

    Behavior on border.color {
        ColorAnimation { duration: 120 }
    }

    Keys.onSpacePressed: function(event) {
        if (root.enabled && !root.loading) {
            event.accepted = true;
            root.clicked();
        }
    }

    Keys.onReturnPressed: function(event) {
        if (root.enabled && !root.loading) {
            event.accepted = true;
            root.clicked();
        }
    }

    Keys.onEnterPressed: function(event) {
        if (root.enabled && !root.loading) {
            event.accepted = true;
            root.clicked();
        }
    }

    Keys.onTabPressed: function(event) {
        event.accepted = true;
        root.navigateNext();
    }

    Keys.onBacktabPressed: function(event) {
        event.accepted = true;
        root.navigatePrev();
    }

    Keys.onUpPressed: function(event) {
        event.accepted = true;
        root.navigateUp();
    }

    Keys.onDownPressed: function(event) {
        event.accepted = true;
        root.navigateDown();
    }

    Keys.onLeftPressed: function(event) {
        event.accepted = true;
        root.navigateLeft();
    }

    Keys.onRightPressed: function(event) {
        event.accepted = true;
        root.navigateRight();
    }

    RowLayout {
        id: contentRow
        anchors.centerIn: parent
        spacing: 8

        Image {
            id: btnIcon
            visible: root.iconSvg.length > 0
            Layout.preferredWidth: 14
            Layout.preferredHeight: 14
            Layout.alignment: Qt.AlignVCenter
            source: root.iconSvg.length > 0 ? Icons.dataUri(root.iconSvg) : ""
            sourceSize: Qt.size(28, 28)
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: btnLabel
            visible: root.text.length > 0
            Layout.alignment: Qt.AlignVCenter
            text: root.text
            color: {
                if (root.variant === "primary")
                    return Theme.actionPrimaryFg;
                if (root.variant === "destructive")
                    return Theme.statusError;
                return Theme.textPrimary;
            }
            font.family: Theme.fontSans
            font.pixelSize: 12
            font.bold: true
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        enabled: root.enabled && !root.loading
        onClicked: root.clicked()
    }
}

