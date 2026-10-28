import QtQuick
import QtQuick as QQ
import QtQuick.Layouts
import qs.config
import qs.utils

Rectangle {
    id: root

    property alias text: field.text
    property string placeholder: ""
    property string iconSvg: ""
    property color iconColor: Theme.textPrimary
    property bool isPassword: false
    property alias echoMode: field.echoMode
    property alias wrapMode: field.wrapMode
    property bool isError: false
    property alias activeFocusOnPress: field.activeFocusOnPress
    property alias readOnly: field.readOnly
    property alias textInput: field
    property int padding: 10
    property int itemSpacing: 10

    signal accepted()
    signal returnPressed(var event)
    signal textEdited(string newText)
    signal keyPressed(var event)

    implicitWidth: 280
    implicitHeight: Math.max(37, Math.ceil(field.contentHeight) + (padding * 2))

    color: "transparent"
    border.width: 1
    border.color: {
        if (isError)
            return Theme.statusError;
        if (field.activeFocus)
            return Theme.borderFocus;
        return Theme.borderInput;
    }

    Behavior on border.color {
        ColorAnimation { duration: 150 }
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: root.padding
        anchors.rightMargin: root.padding
        anchors.topMargin: root.padding
        anchors.bottomMargin: root.padding
        spacing: root.itemSpacing

        // Optional Leading Icon
        Image {
            id: leadingIcon
            visible: root.iconSvg.length > 0
            Layout.preferredWidth: 12
            Layout.preferredHeight: 12
            Layout.alignment: Qt.AlignVCenter
            source: root.iconSvg.length > 0 ? Icons.dataUri(root.iconSvg) : ""
            sourceSize: Qt.size(24, 24)
            fillMode: Image.PreserveAspectFit
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: root.placeholder
                color: Theme.textPlaceholder
                font.family: Theme.fontSans
                font.pixelSize: 12
                font.weight: Font.Normal
                elide: Text.ElideRight
                visible: field.text.length === 0
            }

            QQ.TextInput {
                id: field
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: QQ.TextInput.AlignVCenter

                echoMode: root.isPassword ? QQ.TextInput.Password : QQ.TextInput.Normal
                passwordCharacter: "•"
                color: Theme.textPrimary
                font.family: Theme.fontSans
                font.pixelSize: 12
                selectionColor: Theme.accentBlue
                clip: true
                selectByMouse: true

                onTextChanged: {
                    root.textEdited(text);
                }

                onAccepted: {
                    root.accepted();
                }

                Keys.onReturnPressed: function(event) {
                    root.returnPressed(event);
                }

                Keys.onEnterPressed: function(event) {
                    root.returnPressed(event);
                }

                Keys.onPressed: function(event) {
                    root.keyPressed(event);
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.IBeamCursor
        onPressed: function(mouse) {
            field.forceActiveFocus();
            mouse.accepted = false;
        }
    }

    function forceActiveFocus() {
        field.forceActiveFocus();
    }

    function clear() {
        field.text = "";
    }
}
