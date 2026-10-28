import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components.controls as Controls

Item {
    id: root

    property string iconSvg: ""
    property string placeholder: ""
    property string textValue: ""
    property bool canRemove: false

    signal textEdited(string newText)
    signal addRequested()
    signal removeRequested()
    signal saveRequested()

    implicitWidth: 400
    implicitHeight: inputField.implicitHeight
    Layout.preferredWidth: 400
    Layout.preferredHeight: implicitHeight

    Controls.TextInput {
        id: inputField
        anchors.fill: parent
        iconSvg: root.iconSvg
        placeholder: root.placeholder
        text: root.textValue
        wrapMode: TextInput.Wrap

        onTextEdited: function(newText) {
            if (newText !== root.textValue) {
                root.textEdited(newText);
            }
        }

        onReturnPressed: function(event) {
            if (event.modifiers & Qt.ControlModifier) {
                root.saveRequested();
            } else {
                root.addRequested();
            }
        }

        onKeyPressed: function(event) {
            if (event.key === Qt.Key_Backspace && text.length === 0 && root.canRemove) {
                event.accepted = true;
                root.removeRequested();
            }
        }
    }
}
