import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config

PanelWindow {
    id: root

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    color: Theme.bgLoginCanvas

    FocusScope {
        id: focusScope
        anchors.fill: parent
        focus: true

        // Redirect stray keystrokes back to loginView input
        Keys.onPressed: function(event) {
            loginView.focusInput();
            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                event.accepted = true;
                loginView.submitPin();
            } else if (event.text.length > 0 && event.key !== Qt.Key_Escape) {
                loginView.pinInput.text += event.text;
                event.accepted = true;
            }
        }

        // Swallow outside clicks
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
            hoverEnabled: true
            onPressed: loginView.focusInput()
            onWheel: function(wheel) {
                wheel.accepted = true;
            }
        }

        LoginView {
            id: loginView
            anchors.centerIn: parent
            onLoginSuccess: Qt.quit()
        }

        Component.onCompleted: {
            Qt.callLater(function() {
                loginView.focusInput();
            });
        }
    }
}

