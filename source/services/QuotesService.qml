pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.config

Singleton {
    id: root

    readonly property var databases: Config.quoteDatabases
    property int selectedDatabaseIndex: 0
    property bool saving: false
    property string statusMessage: ""
    property bool statusIsError: false

    signal saveSucceeded(string dbLabel)
    signal saveFailed(string errorMessage)

    Process {
        id: saveProcess
        property string payloadJson: "{}"

        command: [
            "nu",
            "-c",
            "use /home/terra/.config/nushell/scripts/quotes.nu; " +
            "let p = ($env.QUOTE_PAYLOAD | from json); " +
            "let authors = if ($p.authors | is-empty) { null } else { $p.authors }; " +
            "let sources = if ($p.sources | is-empty) { null } else { $p.sources }; " +
            "let time = if ($p.time | is-empty) { null } else { $p.time | into datetime }; " +
            "quotes add $p.words --authors $authors --sources $sources --time $time --database $p.database"
        ]
        environment: ({
            QUOTE_PAYLOAD: saveProcess.payloadJson
        })

        stderr: StdioCollector {
            id: stderrCollector
        }

        onExited: function(exitCode, exitStatus) {
            root.saving = false;
            const currentDb = root.databases[root.selectedDatabaseIndex];
            const dbLabel = currentDb ? currentDb.label.toLowerCase() : "database";

            if (exitCode === 0) {
                root.statusIsError = false;
                root.statusMessage = "Saved to " + dbLabel + ".json";
                root.saveSucceeded(dbLabel);
            } else {
                root.statusIsError = true;
                const errText = stderrCollector.text.trim();
                root.statusMessage = errText.length > 0 ? errText.split("\n")[0] : ("Failed (exit " + exitCode + ")");
                root.saveFailed(root.statusMessage);
            }
        }
    }

    function saveQuote(payload) {
        if (root.saving || !payload || !payload.words || payload.words.length === 0)
            return false;

        root.saving = true;
        root.statusIsError = false;
        const currentDb = root.databases[root.selectedDatabaseIndex];
        const dbLabel = currentDb ? currentDb.label.toLowerCase() : "database";
        root.statusMessage = "Saving to " + dbLabel + ".json...";

        saveProcess.payloadJson = JSON.stringify(payload);
        saveProcess.running = true;
        return true;
    }
}

