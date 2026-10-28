import QtQuick
import QtQuick as QQ
import QtQuick.Layouts
import qs.config
import qs.utils

Rectangle {
    id: root

    // --- Figma Component Properties (Node 99:115 "Input Text") ---
    // 1. Type: "Default" | "With action"
    property string type: "Default"
    property alias variant: root.type

    // 2. Text / Placeholder (Figma property: Text, default "Search")
    property string placeholder: "Search"
    property alias text: field.text

    // 3. Show leading icon (Figma property: Show leading icon, default true)
    property bool showLeadingIcon: true

    // 4. Leading icon (Figma property: Leading icon, default Search)
    property string leadingIconSvg: iconSvg.length > 0 ? iconSvg : (showLeadingIcon ? Icons.search(leadingIconColor) : "")
    property string iconSvg: ""
    property color leadingIconColor: Theme.iconSubtle

    // 5. Trailing icon (Figma property: Trailing icon, default Plus 12x12)
    property string trailingIconSvg: Icons.plus12(trailingIconColor)
    property color trailingIconColor: Theme.iconSubtle
    property bool trailingActionVisible: false
    readonly property bool withAction: (type === "With action" || trailingActionVisible)

    // --- Input Behavior & State ---
    property bool isPassword: false
    property alias echoMode: field.echoMode
    property alias wrapMode: field.wrapMode
    property bool isError: false
    property alias activeFocusOnPress: field.activeFocusOnPress
    property alias readOnly: field.readOnly
    property alias textInput: field
    property int padding: 10
    property int itemSpacing: 10

    // --- Signals ---
    signal actionClicked()
    signal accepted()
    signal returnPressed(var event)
    signal textEdited(string newText)
    signal keyPressed(var event)

    implicitWidth: 306
    implicitHeight: Math.max(37, Math.ceil(field.contentHeight) + (padding * 2))

    color: "transparent"
    clip: true
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
        id: contentRow
        z: 2
        anchors.fill: parent
        anchors.leftMargin: root.padding
        anchors.rightMargin: root.padding
        anchors.topMargin: root.padding
        anchors.bottomMargin: root.padding
        spacing: root.itemSpacing

        // Leading Icon (12x12)
        Image {
            id: leadingIcon
            visible: root.showLeadingIcon && root.leadingIconSvg.length > 0
            Layout.preferredWidth: 12
            Layout.preferredHeight: 12
            Layout.alignment: Qt.AlignVCenter
            source: root.leadingIconSvg.length > 0 ? Icons.dataUri(root.leadingIconSvg) : ""
            sourceSize: Qt.size(24, 24)
            fillMode: Image.PreserveAspectFit
        }

        // Text input field + placeholder
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text {
                id: placeholderText
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

        // Trailing Action Icon (12x12, Type: "With action")
        Item {
            id: actionContainer
            visible: root.withAction
            Layout.preferredWidth: 12
            Layout.preferredHeight: 12
            Layout.alignment: Qt.AlignVCenter

            Image {
                anchors.fill: parent
                source: root.trailingIconSvg.length > 0 ? Icons.dataUri(root.trailingIconSvg) : ""
                sourceSize: Qt.size(24, 24)
                fillMode: Image.PreserveAspectFit
                opacity: actionMouse.pressed ? 0.6 : (actionMouse.containsMouse ? 1.0 : 0.85)

                Behavior on opacity {
                    NumberAnimation { duration: 100 }
                }
            }

            MouseArea {
                id: actionMouse
                anchors.fill: parent
                anchors.margins: -4
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.actionClicked()
            }
        }
    }

    MouseArea {
        id: backgroundFocusArea
        z: 1
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
