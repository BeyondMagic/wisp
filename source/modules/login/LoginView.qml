import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.config
import qs.services
import qs.utils
import qs.components.controls as Controls
import qs.components.effects as Effects

Column {
    id: root

    spacing: 62

    signal loginSuccess()
    signal pinEdited(string text)

    property bool isError: false
    property alias pinInput: pinInput

    function focusInput() {
        pinInput.forceActiveFocus();
    }

    // 1. User Avatar (77x77, 2px outside stroke #09090b)
    Item {
        anchors.horizontalCenter: parent.horizontalCenter
        width: 77
        height: 77

        // 2px outside stroke
        Rectangle {
            anchors.centerIn: parent
            width: 81
            height: 81
            radius: 40.5
            color: "transparent"
            border.width: 2
            border.color: Theme.borderInverse
        }

        // Circular profile image
        ClippingRectangle {
            anchors.fill: parent
            radius: 38.5
            color: "#ffffff"
            border.width: 0

            Image {
                anchors.fill: parent
                source: Qt.resolvedUrl("../../" + Config.avatarPath)
                fillMode: Image.PreserveAspectCrop
                smooth: true
                mipmap: true
            }
        }
    }

    // 2. Display Name (Gued Regular 36px, #60cdea)
    Item {
        anchors.horizontalCenter: parent.horizontalCenter
        width: 588
        height: 25

        Text {
            anchors.centerIn: parent
            text: Config.displayName
            color: Theme.accentBlue
            font.family: Theme.fontDisplay
            font.pixelSize: 36
            font.weight: Font.Normal
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    // 3. Input & Fingerprint Row
    Item {
        anchors.horizontalCenter: parent.horizontalCenter
        width: inputRowLayout.implicitWidth
        height: 53

        Row {
            id: inputRowLayout
            anchors.centerIn: parent
            spacing: 10

            // PIN Input with Shake Effect
            Item {
                width: 282
                height: 37

                Controls.TextInput {
                    id: pinInput
                    anchors.fill: parent
                    focus: true
                    placeholder: "PIN"
                    isPassword: true
                    iconSvg: Icons.key("#F4F4F5")
                    isError: root.isError
                    enabled: !PamService.authenticating

                    onTextEdited: function(newText) {
                        if (newText.length > 0 && root.isError) {
                            root.isError = false;
                        }
                        root.pinEdited(newText);
                    }

                    onAccepted: root.submitPin()
                    onReturnPressed: root.submitPin()

                    Effects.ShakeEffect {
                        id: shake
                        targetItem: pinInput
                    }
                }
            }

            // Fingerprint indicator (conditional on hardware support)
            FingerprintIndicator {
                id: fpIndicator
                visible: FingerprintService.hasSupport
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    function submitPin() {
        if (PamService.authenticating || pinInput.text.length === 0)
            return;

        root.isError = false;
        PamService.authenticate(pinInput.text);
    }

    Connections {
        target: PamService

        function onAuthSucceeded() {
            root.isError = false;
            root.loginSuccess();
        }

        function onAuthFailed(reason) {
            root.isError = true;
            pinInput.clear();
            pinInput.forceActiveFocus();
            shake.trigger();
        }
    }

    Connections {
        target: FingerprintService

        function onFingerprintMatched() {
            root.isError = false;
            exitTimer.start();
        }

        function onFingerprintNotRecognized() {
            // Scanner state is updated automatically inside FingerprintService
        }
    }

    Timer {
        id: exitTimer
        interval: 260
        repeat: false
        onTriggered: root.loginSuccess()
    }

    Component.onCompleted: {
        Qt.callLater(function() {
            pinInput.forceActiveFocus();
        });
    }
}

