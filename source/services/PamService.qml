pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pam

Singleton {
    id: root

    property bool authenticating: false
    property string status: "idle" // "idle" | "authenticating" | "success" | "error"
    property string errorMessage: ""

    signal authSucceeded()
    signal authFailed(string reason)
    signal pamMessageReceived(string message)

    property string _passwordBuffer: ""

    PamContext {
        id: pam
        configDirectory: "../pam.d"
        config: "qs-login"

        onPamMessage: {
            root.pamMessageReceived(pam.message);
            if (pam.responseRequired) {
                pam.respond(root._passwordBuffer);
            }
        }

        onResponseRequiredChanged: {
            if (responseRequired) {
                pam.respond(root._passwordBuffer);
            }
        }

        onCompleted: function(result) {
            root.authenticating = false;
            root._passwordBuffer = "";
            if (result === PamResult.Success) {
                root.status = "success";
                root.authSucceeded();
            } else {
                root.status = "error";
                root.errorMessage = "Authentication failed";
                root.authFailed(root.errorMessage);
            }
        }

        onError: function(error) {
            root.authenticating = false;
            root._passwordBuffer = "";
            root.status = "error";
            root.errorMessage = "PAM error occurred";
            root.authFailed(root.errorMessage);
        }
    }

    function authenticate(password) {
        if (authenticating || !password || password.length === 0)
            return;

        authenticating = true;
        status = "authenticating";
        errorMessage = "";
        _passwordBuffer = password;
        pam.start();
    }

    function finishSession() {
        FingerprintService.stopScanning();
        Qt.quit();
    }
}
