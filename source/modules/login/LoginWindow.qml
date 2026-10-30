import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.services

Variants {
    id: root
    model: Quickshell.screens

    property string sharedPin: ""

    Connections {
        target: PamService
        function onAuthFailed() {
            root.sharedPin = "";
        }
    }

    PanelWindow {
        id: win
        required property var modelData
        screen: modelData

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
                } else if (event.key === Qt.Key_Backspace) {
                    event.accepted = true;
                    if (root.sharedPin.length > 0) {
                        root.sharedPin = root.sharedPin.slice(0, -1);
                    }
                } else if (event.key === Qt.Key_Escape) {
                    event.accepted = true;
                    root.sharedPin = "";
                } else if (event.text.length > 0) {
                    root.sharedPin += event.text;
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
                onLoginSuccess: PamService.finishSession()

                onPinEdited: function(text) {
                    if (root.sharedPin !== text) {
                        root.sharedPin = text;
                    }
                }

                Connections {
                    target: root
                    function onSharedPinChanged() {
                        if (loginView.pinInput.text !== root.sharedPin) {
                            loginView.pinInput.text = root.sharedPin;
                        }
                    }
                }

                Component.onCompleted: {
                    if (loginView.pinInput.text !== root.sharedPin) {
                        loginView.pinInput.text = root.sharedPin;
                    }
                }
            }

            Component.onCompleted: {
                Qt.callLater(function() {
                    loginView.focusInput();
                });
            }
        }
    }
}
