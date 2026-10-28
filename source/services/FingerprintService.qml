pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.config

Singleton {
    id: root

    property bool hasSupport: false
    // State: "Default" | "Scanning" | "Filled" | "Not recognized"
    property string state: "Default"
    property bool dbusSignalReceived: false

    signal fingerprintMatched()
    signal fingerprintNotRecognized()

    // 1. Initial hardware check: fprintd-list $USER (exit code 0 = supported)
    Process {
        id: checkProcess
        command: ["sh", "-c", "fprintd-list \"$1\" >/dev/null 2>&1", "sh", Config.currentUser]

        onExited: function(exitCode, exitStatus) {
            if (exitCode === 0) {
                root.hasSupport = true;
                root.state = "Scanning";
                dbusMonitorProcess.running = true;
                verifyProcess.running = true;
            } else {
                root.hasSupport = false;
                root.state = "Default";
            }
        }
    }

    // 2. Primary Target (Method 2: D-Bus signals on net.reactivated.Fprint)
    Process {
        id: dbusMonitorProcess
        command: [
            "gdbus",
            "monitor",
            "--system",
            "--dest", "net.reactivated.Fprint",
            "--object-path", "/net/reactivated/Fprint/Device/0"
        ]

        stdout: SplitParser {
            onRead: function(line) {
                root.handleDBusSignal(line);
            }
        }
    }

    function handleDBusSignal(line) {
        const text = line.trim();
        if (text.length === 0)
            return;

        if (text.indexOf("VerifyFingerSelected") !== -1 || text.indexOf("verify-started") !== -1) {
            root.dbusSignalReceived = true;
            root.state = "Scanning";
            return;
        }

        if (text.indexOf("VerifyStatus") !== -1) {
            root.dbusSignalReceived = true;
            if (text.indexOf("verify-match") !== -1) {
                root.notifyMatched();
            } else if (
                text.indexOf("verify-no-match") !== -1 ||
                text.indexOf("verify-retry-scan") !== -1 ||
                text.indexOf("verify-swipe-too-short") !== -1 ||
                text.indexOf("verify-finger-not-centered") !== -1 ||
                text.indexOf("verify-remove-and-retry") !== -1 ||
                text.indexOf("verify-unknown-error") !== -1 ||
                text.indexOf("verify-disconnected") !== -1
            ) {
                root.notifyNotRecognized();
            }
        }
    }

    // 3. Fallback Target (Method 1: PAM & CLI Text Stream Parsing)
    function handleTextFallback(message) {
        if (!root.hasSupport || !message)
            return;

        const msg = message.toLowerCase();
        if (msg.indexOf("verify-match") !== -1) {
            root.notifyMatched();
        } else if (
            msg.indexOf("verify-no-match") !== -1 ||
            msg.indexOf("verify-retry-scan") !== -1 ||
            msg.indexOf("verify-swipe-too-short") !== -1 ||
            msg.indexOf("verify-finger-not-centered") !== -1 ||
            msg.indexOf("verify-remove-and-retry") !== -1 ||
            msg.indexOf("failed") !== -1 ||
            msg.indexOf("not recognized") !== -1
        ) {
            root.notifyNotRecognized();
        } else if (
            msg.indexOf("place your") !== -1 ||
            msg.indexOf("swipe your") !== -1 ||
            msg.indexOf("scanning") !== -1
        ) {
            if (root.state !== "Filled") {
                root.state = "Scanning";
            }
        }
    }

    // Parallel fprintd-verify worker
    Process {
        id: verifyProcess
        command: ["fprintd-verify", Config.currentUser]

        stdout: SplitParser {
            onRead: function(line) {
                if (!root.dbusSignalReceived) {
                    root.handleTextFallback(line);
                }
            }
        }

        stderr: SplitParser {
            onRead: function(line) {
                if (!root.dbusSignalReceived) {
                    root.handleTextFallback(line);
                }
            }
        }

        onExited: function(exitCode, exitStatus) {
            if (root.state === "Filled")
                return;

            if (exitCode === 0) {
                root.notifyMatched();
            } else if (root.hasSupport) {
                root.notifyNotRecognized();
                restartTimer.restart();
            }
        }
    }

    Timer {
        id: restartTimer
        interval: 1400
        repeat: false
        onTriggered: {
            if (root.hasSupport && root.state !== "Filled") {
                root.state = "Scanning";
                if (!verifyProcess.running) {
                    verifyProcess.running = true;
                }
            }
        }
    }

    function notifyMatched() {
        root.state = "Filled";
        root.fingerprintMatched();
    }

    function notifyNotRecognized() {
        if (root.state === "Filled")
            return;
        root.state = "Not recognized";
        root.fingerprintNotRecognized();
        restartTimer.restart();
    }

    function startScanning() {
        if (root.hasSupport && !verifyProcess.running) {
            root.state = "Scanning";
            verifyProcess.running = true;
        }
    }

    Component.onCompleted: {
        checkProcess.running = true;
    }
}

