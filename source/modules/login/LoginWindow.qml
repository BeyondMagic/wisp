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
            event.accepted = true;
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
    }
}

