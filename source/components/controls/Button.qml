import QtQuick
import QtQuick.Layouts
import qs.config
import qs.utils

Rectangle {
    id: root

    property string text: ""
    property string iconSvg: ""
    property string variant: "primary" // "primary" | "secondary" | "outline" | "icon"
    property bool loading: false
    property alias cursorShape: mouseArea.cursorShape
    property int paddingHorizontal: 16
    property int paddingVertical: 10
    property int radiusSize: 0

    signal clicked()

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
        if (variant === "secondary" || variant === "icon") {
            return mouseArea.pressed ? Qt.rgba(Theme.textPrimary.r, Theme.textPrimary.g, Theme.textPrimary.b, 0.15)
                 : (mouseArea.containsMouse ? Qt.rgba(Theme.textPrimary.r, Theme.textPrimary.g, Theme.textPrimary.b, 0.08) : "transparent");
        }
        return "transparent";
    }

    border.width: (variant === "outline" || variant === "secondary") ? 1 : 0
    border.color: Theme.borderButton

    Behavior on color {
        ColorAnimation { duration: 120 }
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
            color: root.variant === "primary" ? Theme.actionPrimaryFg : Theme.textPrimary
            font.family: Theme.fontSans
            font.pixelSize: 12
            font.weight: Font.Medium
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

