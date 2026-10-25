import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pam
import Quickshell.Wayland
import Quickshell.Widgets

PanelWindow {
    id: root

    readonly property string currentUser: Quickshell.env("USER") || "terra"
    readonly property string displayName: "BeyondMagic"

    // --- Theme tokens from Figma VariableCollectionId:108:189 ("Theme Colors", Dark Mode) ---
    readonly property color bgCanvas:        "#050505"
    readonly property color borderInverse:   "#09090b"
    readonly property color accentBlue:      "#60cdea"
    readonly property color textPrimary:     "#fafafa"
    readonly property color textPlaceholder: Qt.rgba(250 / 255, 250 / 255, 250 / 255, 0.60)
    readonly property color actionPrimary:   "#f4f4f5"
    readonly property color borderInput:     Qt.rgba(250 / 255, 250 / 255, 250 / 255, 0.10)
    readonly property color borderButton:    Qt.rgba(244 / 255, 244 / 255, 245 / 255, 0.10)
    readonly property color statusSuccess:   "#4ac26b"
    readonly property color statusWarning:   "#e5c07b"
    readonly property color statusError:     "#ed8d9f"

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    // --- Input blocking & stacking ---
    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    color: root.bgCanvas

    // --- Authentication & Fingerprint State ---
    property string passwordBuffer: ""
    property bool authenticating: false
    property bool loginFailed: false

    // Fingerprint state: "Default" | "Scanning" | "Filled" | "Not recognized"
    property bool hasFingerprintSupport: false
    property string fingerprintState: "Default"
    property bool dbusSignalReceived: false

    function svgDataUri(svgString) {
        return "data:image/svg+xml;utf8," + encodeURIComponent(svgString);
    }

    // Node I136:407;99:180 ("Icon", Name=Key, 12x12)
    readonly property string keyIconSvg: `<svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4.51989 5.58526C4.31932 5.14535 4.21206 4.66867 4.20489 4.18526C4.18963 3.49168 4.3974 2.81153 4.79762 2.24487C5.19784 1.67821 5.76937 1.25498 6.42812 1.03744C7.08687 0.819898 7.79805 0.819544 8.45702 1.03643C9.11599 1.25331 9.68794 1.67598 10.0887 2.24224C10.4895 2.8085 10.698 3.48845 10.6834 4.18203C10.6688 4.87562 10.432 5.54622 10.0078 6.09516C9.58363 6.6441 8.99444 7.04239 8.32695 7.23142C7.65946 7.42046 6.94893 7.39025 6.29989 7.14526" stroke-linecap="round" stroke-linejoin="round" stroke="#F4F4F5"/><path d="M7.94531 4.00977C7.94531 4.14237 7.89263 4.26955 7.79887 4.36332C7.7051 4.45709 7.57792 4.50977 7.44531 4.50977C7.3127 4.50977 7.18553 4.45709 7.09176 4.36332C6.99799 4.26955 6.94531 4.14237 6.94531 4.00977C6.94531 3.87716 6.99799 3.74998 7.09176 3.65621C7.18553 3.56244 7.3127 3.50977 7.44531 3.50977C7.57792 3.50977 7.7051 3.56244 7.79887 3.65621C7.89263 3.74998 7.94531 3.87716 7.94531 4.00977Z" stroke-linecap="round" stroke-linejoin="round" stroke="#F4F4F5"/><path d="M4.51 5.6001L1.54 8.5651C1.395 8.7151 1.325 8.7851 1.29 8.8751C1.255 8.9651 1.25 9.0701 1.25 9.2751V10.1951C1.25 10.6651 1.25 10.9051 1.395 11.0451C1.545 11.1951 1.775 11.1951 2.245 11.1951H2.83501C3.035 11.1951 3.14 11.1951 3.225 11.1651C3.29394 11.1401 3.35655 11.1003 3.4084 11.0485C3.46024 10.9967 3.50005 10.934 3.525 10.8651C3.555 10.7851 3.555 10.6801 3.555 10.4751C3.555 10.2751 3.555 10.1701 3.585 10.0851C3.60995 10.0162 3.64976 9.95354 3.7016 9.9017C3.75345 9.84986 3.81606 9.81005 3.885 9.7851C3.965 9.7551 4.07 9.7551 4.27499 9.7551H4.325C4.585 9.7551 4.71 9.7551 4.81 9.7101C4.921 9.65999 5.00989 9.5711 5.06 9.4601C5.1 9.3601 5.1 9.2351 5.1 8.9801V8.7451C5.1 8.5401 5.1 8.4351 5.14 8.3451C5.18 8.2551 5.25 8.1801 5.39 8.0351L6.275 7.1551" stroke-linecap="round" stroke-linejoin="round" stroke="#F4F4F5"/></svg>`

    // Node 136:417 ("Icon", Name=Fingerprint, 24x24) parameterized by fill hex color
    function fingerprintSvg(fillColor) {
        return `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">` +
            `<path d="M5.81 17.6601C6.85 19.3201 6.85 20.5501 6.85 21.9901H8.85C8.85 20.4701 8.85 18.7501 7.51 16.6001L5.81 17.6601ZM4.5 16.0101C4.57 16.0701 4.65 16.1301 4.71 16.1901L6.21 14.8601C6.09 14.7201 5.94 14.5901 5.79 14.4701C5.72 14.4101 5.64 14.3501 5.58 14.2801C3.92 12.5701 3.07 8.26013 5.58 5.67013C8.1 3.06013 13.65 4.09013 15.36 5.09013C18.05 6.66013 19.46 9.40013 19.47 9.42013L21.26 8.53013C21.19 8.40013 19.59 5.24013 16.37 3.36013C13.84 1.88013 7.41 0.900128 4.15 4.28013C0.78 7.76013 1.9 13.3501 4.15 15.6701C4.27 15.7901 4.39 15.9001 4.52 16.0001L4.5 16.0101Z" fill="${fillColor}"/>` +
            `<path d="M12.8498 21.9798C12.8498 19.9398 12.8498 17.6398 9.64981 13.3798C9.51981 13.1998 9.35981 13.0098 9.18981 12.7998C8.15981 11.5398 7.39981 10.4798 7.79981 9.28983C8.05981 8.49983 8.60981 7.95983 9.43981 7.68983C10.6598 7.27983 12.3598 7.52983 13.4798 8.28983L14.5998 6.63983C12.9498 5.51995 10.6198 5.17983 8.79981 5.79983C7.38981 6.27983 6.35981 7.28983 5.90981 8.66983C5.12981 10.9998 6.70981 12.9198 7.64981 14.0698C7.79981 14.2498 7.93982 14.4198 8.05982 14.5798C10.8598 18.2998 10.8598 20.0898 10.8598 21.9798H12.8598H12.8498ZM20.8298 17.7698C19.8898 13.0898 18.5098 10.0798 16.3698 8.01983L14.9798 9.45983C16.8098 11.2198 18.0098 13.9098 18.8698 18.1598L20.8298 17.7698Z" fill="${fillColor}"/>` +
            `<path d="M16.02 15.9899C14.72 11.4099 11.55 9.2399 11.41 9.1499L10.29 10.8099C10.29 10.8099 13 12.6899 14.09 16.5299L16.01 15.9899H16.02ZM16.85 21.9799C16.85 20.6499 16.74 19.3699 16.51 18.0899L14.54 18.4399C14.75 19.6099 14.85 20.7699 14.85 21.9799H16.85Z" fill="${fillColor}"/>` +
            `</svg>`;
    }

    // --- Check fingerprint support: `fprintd-list $USER` (exit code 0 = supported) ---
    Process {
        id: fprintCheckProcess
        command: ["sh", "-c", "fprintd-list \"$1\" >/dev/null 2>&1", "sh", root.currentUser]

        onExited: function(exitCode, exitStatus) {
            if (exitCode === 0) {
                root.hasFingerprintSupport = true;
                root.fingerprintState = "Scanning";
                fprintDBusMonitor.running = true;
                fprintVerifyProcess.running = true;
            } else {
                root.hasFingerprintSupport = false;
                root.fingerprintState = "Default";
            }
        }
    }

    // --- Tier 1 (Primary Target - Method 2): D-Bus Signals on net.reactivated.Fprint ---
    // Listens to /net/reactivated/Fprint/Device/0 VerifyStatus and VerifyFingerSelected signals.
    Process {
        id: fprintDBusMonitor
        command: [
            "gdbus",
            "monitor",
            "--system",
            "--dest", "net.reactivated.Fprint",
            "--object-path", "/net/reactivated/Fprint/Device/0"
        ]

        stdout: SplitParser {
            onRead: function(line) {
                root.handleFprintDBusSignal(line);
            }
        }
    }

    function handleFprintDBusSignal(line) {
        const text = line.trim();
        if (text.length === 0)
            return;

        if (text.indexOf("VerifyFingerSelected") !== -1 || text.indexOf("verify-started") !== -1) {
            root.dbusSignalReceived = true;
            root.fingerprintState = "Scanning";
            return;
        }

        if (text.indexOf("VerifyStatus") !== -1) {
            root.dbusSignalReceived = true;
            if (text.indexOf("verify-match") !== -1) {
                root.onFingerprintMatched();
            } else if (
                text.indexOf("verify-no-match") !== -1 ||
                text.indexOf("verify-retry-scan") !== -1 ||
                text.indexOf("verify-swipe-too-short") !== -1 ||
                text.indexOf("verify-finger-not-centered") !== -1 ||
                text.indexOf("verify-remove-and-retry") !== -1 ||
                text.indexOf("verify-unknown-error") !== -1 ||
                text.indexOf("verify-disconnected") !== -1
            ) {
                root.onFingerprintNotRecognized();
            }
        }
    }

    // --- Tier 2 (Fallback Target - Method 1): PAM & CLI Text Stream Parsing ---
    function handleFingerprintTextFallback(message) {
        if (!root.hasFingerprintSupport || !message)
            return;

        const msg = message.toLowerCase();
        if (msg.indexOf("verify-match") !== -1) {
            root.onFingerprintMatched();
        } else if (
            msg.indexOf("verify-no-match") !== -1 ||
            msg.indexOf("verify-retry-scan") !== -1 ||
            msg.indexOf("verify-swipe-too-short") !== -1 ||
            msg.indexOf("verify-finger-not-centered") !== -1 ||
            msg.indexOf("verify-remove-and-retry") !== -1 ||
            msg.indexOf("failed") !== -1 ||
            msg.indexOf("not recognized") !== -1
        ) {
            root.onFingerprintNotRecognized();
        } else if (
            msg.indexOf("place your") !== -1 ||
            msg.indexOf("swipe your") !== -1 ||
            msg.indexOf("scanning") !== -1
        ) {
            if (root.fingerprintState !== "Filled") {
                root.fingerprintState = "Scanning";
            }
        }
    }

    // Parallel fprintd-verify worker so fingerprint and PIN work simultaneously
    Process {
        id: fprintVerifyProcess
        command: ["fprintd-verify", root.currentUser]

        stdout: SplitParser {
            onRead: function(line) {
                if (!root.dbusSignalReceived) {
                    root.handleFingerprintTextFallback(line);
                }
            }
        }

        stderr: SplitParser {
            onRead: function(line) {
                if (!root.dbusSignalReceived) {
                    root.handleFingerprintTextFallback(line);
                }
            }
        }

        onExited: function(exitCode, exitStatus) {
            if (root.fingerprintState === "Filled")
                return;

            if (exitCode === 0) {
                root.onFingerprintMatched();
            } else if (root.hasFingerprintSupport) {
                root.onFingerprintNotRecognized();
                fprintRestartTimer.restart();
            }
        }
    }

    Timer {
        id: fprintRestartTimer
        interval: 1400
        repeat: false
        onTriggered: {
            if (root.hasFingerprintSupport && root.fingerprintState !== "Filled") {
                root.fingerprintState = "Scanning";
                if (!fprintVerifyProcess.running) {
                    fprintVerifyProcess.running = true;
                }
            }
        }
    }

    Timer {
        id: exitTimer
        interval: 260
        repeat: false
        onTriggered: Qt.quit()
    }

    function onFingerprintMatched() {
        root.fingerprintState = "Filled";
        root.loginFailed = false;
        exitTimer.start();
    }

    function onFingerprintNotRecognized() {
        if (root.fingerprintState === "Filled")
            return;
        root.fingerprintState = "Not recognized";
        fprintRestartTimer.restart();
    }

    // --- PAM Context for PIN / Password authentication ---
    PamContext {
        id: pam
        configDirectory: "pam.d"
        config: "qs-login"

        // Fallback Target (Method 1): parse standard PAM message stream
        onPamMessage: {
            root.handleFingerprintTextFallback(pam.message);
            if (pam.responseRequired) {
                pam.respond(root.passwordBuffer);
            }
        }

        onResponseRequiredChanged: {
            if (responseRequired) {
                pam.respond(root.passwordBuffer);
            }
        }

        onCompleted: function(result) {
            root.authenticating = false;
            if (result === PamResult.Success) {
                root.loginFailed = false;
                if (root.hasFingerprintSupport) {
                    root.fingerprintState = "Filled";
                }
                Qt.quit();
            } else {
                root.triggerPinFailure();
            }
        }

        onError: function(error) {
            root.authenticating = false;
            root.triggerPinFailure();
        }
    }

    function triggerPinFailure() {
        root.loginFailed = true;
        root.passwordBuffer = "";
        passwordField.text = "";
        passwordField.forceActiveFocus();
        shakeAnimation.restart();
    }

    function submitPassword() {
        if (root.authenticating || root.passwordBuffer.length === 0)
            return;

        root.authenticating = true;
        root.loginFailed = false;
        pam.start();
    }

    Component.onCompleted: {
        passwordField.forceActiveFocus();
        fprintCheckProcess.running = true;
    }

    // --- Reusable Fingerprint Component (Figma Node 136:540) ---
    // States: "Default" | "Filled" | "Scanning" | "Not recognized"
    component FingerprintIndicator: Item {
        id: fpRoot
        property string stateName: root.fingerprintState
        property real revealProgress: 0.0

        implicitWidth: 36
        implicitHeight: 36
        width: 36
        height: 36

        onStateNameChanged: {
            if (stateName === "Scanning") {
                scanningLoop.restart();
            } else {
                scanningLoop.stop();
                if (stateName === "Filled") {
                    fillCompleteAnim.restart();
                } else {
                    revealProgress = 0.0;
                }
            }
        }

        Component.onCompleted: {
            if (stateName === "Scanning") {
                scanningLoop.start();
            }
        }

        // Bottom-to-top green reveal motion during "Scanning"
        SequentialAnimation {
            id: scanningLoop
            loops: Animation.Infinite
            running: false

            PropertyAction {
                target: fpRoot
                property: "revealProgress"
                value: 0.0
            }
            NumberAnimation {
                target: fpRoot
                property: "revealProgress"
                from: 0.0
                to: 1.0
                duration: 1100
                easing.type: Easing.InOutCubic
            }
            PauseAnimation {
                duration: 200
            }
            NumberAnimation {
                target: fpRoot
                property: "revealProgress"
                from: 1.0
                to: 0.0
                duration: 650
                easing.type: Easing.InOutQuad
            }
            PauseAnimation {
                duration: 150
            }
        }

        NumberAnimation {
            id: fillCompleteAnim
            target: fpRoot
            property: "revealProgress"
            to: 1.0
            duration: 220
            easing.type: Easing.OutCubic
        }

        // Base Button Icon (36x36, cornerRadius 5, 1px inside stroke)
        Rectangle {
            id: baseBox
            anchors.fill: parent
            radius: 5
            color: "transparent"
            border.width: 1
            border.color: fpRoot.stateName === "Not recognized" ? root.statusWarning : root.borderButton

            Behavior on border.color {
                ColorAnimation { duration: 160 }
            }

            Image {
                x: 6
                y: 6
                width: 24
                height: 24
                sourceSize: Qt.size(48, 48)
                fillMode: Image.PreserveAspectFit
                source: {
                    if (fpRoot.stateName === "Not recognized")
                        return root.svgDataUri(root.fingerprintSvg("#E5C07B"));
                    if (fpRoot.stateName === "Filled")
                        return root.svgDataUri(root.fingerprintSvg("#4AC26B"));
                    return root.svgDataUri(root.fingerprintSvg("#FAFAFA"));
                }
            }
        }

        // Node 147:177: "Bottom-to-top clipped reveal"
        // Matching counter-motion keeps the green fingerprint fixed in place as the viewport rises.
        Item {
            id: clippedViewport
            visible: fpRoot.stateName === "Scanning" || fpRoot.stateName === "Filled"
            x: 0
            y: parent.height - height
            width: 36
            height: Math.round(fpRoot.revealProgress * 36)
            clip: true

            Item {
                x: 0
                y: -(36 - clippedViewport.height)
                width: 36
                height: 36

                Image {
                    x: 6
                    y: 6
                    width: 24
                    height: 24
                    sourceSize: Qt.size(48, 48)
                    fillMode: Image.PreserveAspectFit
                    source: root.svgDataUri(root.fingerprintSvg("#4AC26B"))
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (root.hasFingerprintSupport && !fprintVerifyProcess.running) {
                    root.fingerprintState = "Scanning";
                    fprintVerifyProcess.running = true;
                }
                passwordField.forceActiveFocus();
            }
        }
    }

    FocusScope {
        id: contentScope
        anchors.fill: parent
        focus: true

        // If the password field ever loses focus, typing redirects back to it.
        Keys.onPressed: function(event) {
            if (!passwordField.activeFocus) {
                passwordField.forceActiveFocus();
            }
            event.accepted = true;
        }

        // Swallow all mouse clicks and wheel events outside interactive controls.
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
            hoverEnabled: true
            onPressed: passwordField.forceActiveFocus()
            onWheel: function(wheel) {
                wheel.accepted = true;
            }
        }

        // --- Center UI Stack (Figma Node 136:412 / 152:458 "Frame 1") ---
        Column {
            id: mainStack
            anchors.centerIn: parent
            spacing: 62

            // 1. User Avatar (Figma Node 136:400 "Frame 1631": 77x77, cornerRadius 38, 2px outside stroke #09090b)
            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 77
                height: 77

                // 2px OUTSIDE stroke (#09090b)
                Rectangle {
                    anchors.centerIn: parent
                    width: 81
                    height: 81
                    radius: 40.5
                    color: "transparent"
                    border.width: 2
                    border.color: root.borderInverse
                }

                // 77x77 Circular clipped profile image
                ClippingRectangle {
                    anchors.fill: parent
                    radius: 38.5
                    color: "#ffffff"
                    border.width: 0

                    Image {
                        anchors.fill: parent
                        source: Qt.resolvedUrl("assets/avatar.png")
                        fillMode: Image.PreserveAspectCrop
                        smooth: true
                        mipmap: true
                    }
                }
            }

            // 2. Display Name (Figma Node 136:402 "BeyondMagic": Gued Regular 36px, #60cdea, height 25)
            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 588
                height: 25

                Text {
                    anchors.centerIn: parent
                    text: root.displayName
                    color: root.accentBlue
                    font.family: "Gued"
                    font.pixelSize: 36
                    font.weight: Font.Normal
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            // 3. Input & Fingerprint Row (Figma Node 136:427 "Frame 1648": height 53, paddingTop/Bottom 8, itemSpacing 10)
            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: inputRowLayout.implicitWidth
                height: 53

                Row {
                    id: inputRowLayout
                    anchors.centerIn: parent
                    spacing: 10

                    // Input Text (Figma Node 136:407: 282x37, 1px inside stroke #fafafa @ 10%, padding 10, gap 10)
                    Rectangle {
                        id: pinInputBox
                        width: 282
                        height: 37
                        color: "transparent"
                        border.width: 1
                        border.color: root.loginFailed ? root.statusError : root.borderInput
                        clip: true

                        Behavior on border.color {
                            ColorAnimation { duration: 150 }
                        }

                        transform: Translate {
                            id: shakeTranslate
                            x: 0
                        }

                        SequentialAnimation {
                            id: shakeAnimation
                            NumberAnimation { target: shakeTranslate; property: "x"; to: -8; duration: 45; easing.type: Easing.OutQuad }
                            NumberAnimation { target: shakeTranslate; property: "x"; to: 8;  duration: 55; easing.type: Easing.InOutQuad }
                            NumberAnimation { target: shakeTranslate; property: "x"; to: -6; duration: 55; easing.type: Easing.InOutQuad }
                            NumberAnimation { target: shakeTranslate; property: "x"; to: 6;  duration: 55; easing.type: Easing.InOutQuad }
                            NumberAnimation { target: shakeTranslate; property: "x"; to: -3; duration: 45; easing.type: Easing.InOutQuad }
                            NumberAnimation { target: shakeTranslate; property: "x"; to: 0;  duration: 45; easing.type: Easing.InQuad }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            anchors.rightMargin: 10
                            anchors.topMargin: 10
                            anchors.bottomMargin: 10
                            spacing: 10

                            // Leading Key Icon (12x12)
                            Image {
                                Layout.preferredWidth: 12
                                Layout.preferredHeight: 12
                                Layout.alignment: Qt.AlignVCenter
                                source: root.svgDataUri(root.keyIconSvg)
                                sourceSize: Qt.size(24, 24)
                                fillMode: Image.PreserveAspectFit
                            }

                            // PIN TextInput + Placeholder
                            Item {
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                Text {
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "PIN"
                                    color: root.textPlaceholder
                                    font.family: "Inter"
                                    font.pixelSize: 12
                                    font.weight: Font.Normal
                                    visible: passwordField.text.length === 0
                                }

                                TextInput {
                                    id: passwordField
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.verticalCenter: parent.verticalCenter
                                    verticalAlignment: TextInput.AlignVCenter

                                    echoMode: TextInput.Password
                                    passwordCharacter: "•"
                                    color: root.textPrimary
                                    font.family: "Inter"
                                    font.pixelSize: 12
                                    selectionColor: root.accentBlue
                                    clip: true

                                    focus: true
                                    enabled: !root.authenticating

                                    onTextChanged: {
                                        root.passwordBuffer = text;
                                        if (text.length > 0 && root.loginFailed) {
                                            root.loginFailed = false;
                                        }
                                    }

                                    Keys.onReturnPressed: root.submitPassword()
                                    Keys.onEnterPressed: root.submitPassword()
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.IBeamCursor
                            onPressed: function(mouse) {
                                passwordField.forceActiveFocus();
                                mouse.accepted = false;
                            }
                        }
                    }

                    // Fingerprint Indicator (Figma Node 145:647: 36x36, only shown if fprintd-list $USER returns 0)
                    FingerprintIndicator {
                        id: fingerprintWidget
                        visible: root.hasFingerprintSupport
                        anchors.verticalCenter: pinInputBox.verticalCenter
                    }
                }
            }
        }
    }
}
