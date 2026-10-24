import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

FloatingWindow {
    id: root

    title: "Quote Maker"
    implicitWidth: 472
    implicitHeight: Math.max(444, outerFrame.implicitHeight)
    minimumSize: Qt.size(472, 444)
    visible: true
    color: "transparent"

    // Theme tokens from Figma VariableCollectionId:108:189 ("Theme Colors")
    property bool darkMode: false

    readonly property color bgCanvas:        darkMode ? "#09090b" : "#ffffff"
    readonly property color textPrimary:     darkMode ? "#fafafa" : "#000000"
    readonly property color textPlaceholder: darkMode ? Qt.rgba(0.98, 0.98, 0.98, 0.60) : Qt.rgba(0, 0, 0, 0.60)
    readonly property color borderOuter:     darkMode ? Qt.rgba(0.98, 0.98, 0.98, 0.05) : Qt.rgba(0, 0, 0, 0.05)
    readonly property color borderInput:     darkMode ? Qt.rgba(0.98, 0.98, 0.98, 0.10) : Qt.rgba(0, 0, 0, 0.10)
    readonly property color borderFocus:     "#60cdea"
    readonly property color actionPrimaryBg: darkMode ? "#f4f4f5" : "#171717"
    readonly property color actionPrimaryFg: darkMode ? "#09090b" : "#ffffff"
    readonly property color brandBlue:       "#60cdea"
    readonly property color brandBlueSoft:   Qt.rgba(96 / 255, 205 / 255, 234 / 255, 0.25)
    readonly property color statusError:     darkMode ? "#ed8d9f" : "#cf6679"
    readonly property color statusSuccess:   darkMode ? "#4ac26b" : "#2da24e"

    // Dynamic lists for quotations (words), authors, and sources
    ListModel {
        id: quotationsModel
        ListElement { value: "" }
    }

    ListModel {
        id: authorsModel
        ListElement { value: "" }
    }

    ListModel {
        id: sourcesModel
        ListElement { value: "" }
    }

    property string quoteTime: ""
    property int selectedDatabaseIndex: 0
    property bool databaseMenuOpen: false
    property string statusMessage: ""
    property bool statusIsError: false

    // Actual quote databases used by /home/terra/.config/nushell/scripts/quotes.nu
    readonly property var databases: [
        { label: "General",  path: "/home/terra/storage/desktop/quotes/general.json" },
        { label: "Personal", path: "/home/terra/storage/desktop/quotes/personal.json" },
        { label: "TV",       path: "/home/terra/storage/desktop/quotes/tv.json" },
        { label: "Books",    path: "/home/terra/storage/desktop/quotes/books.json" },
        { label: "Music",    path: "/home/terra/storage/desktop/quotes/music.json" },
        { label: "Story",    path: "/home/terra/storage/desktop/quotes/story.json" }
    ]

    function ordinal(n) {
        const s = ["th", "st", "nd", "rd"];
        const v = n % 100;
        return n + (s[(v - 20) % 10] || s[v] || s[0]);
    }

    function resetForm() {
        quotationsModel.clear();
        quotationsModel.append({ value: "" });
        authorsModel.clear();
        authorsModel.append({ value: "" });
        sourcesModel.clear();
        sourcesModel.append({ value: "" });
        quoteTime = "";
        databaseMenuOpen = false;
    }

    function collectNonEmpty(model) {
        const out = [];
        for (let i = 0; i < model.count; i++) {
            const v = model.get(i).value.trim();
            if (v.length > 0)
                out.push(v);
        }
        return out;
    }

    function saveQuote() {
        if (saveProcess.running)
            return;

        const words = collectNonEmpty(quotationsModel);
        if (words.length === 0) {
            statusIsError = true;
            statusMessage = "Enter at least 1 quotation line.";
            return;
        }

        const db = databases[selectedDatabaseIndex];
        const payload = {
            words: words,
            authors: collectNonEmpty(authorsModel),
            sources: collectNonEmpty(sourcesModel),
            time: quoteTime.trim(),
            database: db.path
        };

        statusIsError = false;
        statusMessage = "Saving to " + db.label.toLowerCase() + ".json...";

        saveProcess.payloadJson = JSON.stringify(payload);
        saveProcess.running = true;
    }

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
            if (exitCode === 0) {
                const dbLabel = root.databases[root.selectedDatabaseIndex].label.toLowerCase();
                root.resetForm();
                root.statusIsError = false;
                root.statusMessage = "Saved to " + dbLabel + ".json";
            } else {
                root.statusIsError = true;
                const errText = stderrCollector.text.trim();
                root.statusMessage = errText.length > 0 ? errText.split("\n")[0] : ("Failed (exit " + exitCode + ")");
            }
        }
    }

    // Inline SVG helper for crisp 12x12 / 18x18 vector icons extracted from Figma
    function svgDataUri(svgString) {
        return "data:image/svg+xml;utf8," + encodeURIComponent(svgString);
    }

    readonly property string searchIconSvg: `<svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4.87386 0.748535C5.63583 0.748645 6.38287 0.959803 7.03215 1.35859C7.68143 1.75738 8.20756 2.32821 8.55221 3.00778C8.89685 3.68736 9.04652 4.44911 8.98464 5.20856C8.92275 5.96801 8.65172 6.69548 8.20161 7.31028L10.8686 9.44479C10.9805 9.53356 11.0725 9.645 11.1383 9.77179C11.2041 9.89859 11.2424 10.0379 11.2506 10.1805C11.2588 10.3231 11.2367 10.4659 11.1859 10.5994C11.135 10.7329 11.0565 10.8541 10.9555 10.9552C10.8545 11.0562 10.7332 11.1347 10.5997 11.1856C10.4662 11.2364 10.3235 11.2585 10.1808 11.2503C10.0382 11.2421 9.89891 11.2038 9.77212 11.138C9.64532 11.0721 9.53388 10.9802 9.44511 10.8683L7.31061 8.20129C6.78488 8.58638 6.17539 8.84143 5.53209 8.94555C4.88878 9.04967 4.22995 8.99988 3.6096 8.80028C2.98924 8.60067 2.425 8.25693 1.96311 7.79721C1.50122 7.33749 1.15482 6.77487 0.952297 6.15546C0.749774 5.53605 0.696889 4.87747 0.797976 4.23368C0.899062 3.58989 1.15124 2.97921 1.53386 2.45167C1.91647 1.92414 2.41863 1.49476 2.99918 1.19872C3.57974 0.902682 4.22218 0.748407 4.87386 0.748535ZM4.87386 2.24854C4.52914 2.24854 4.18779 2.31643 3.86931 2.44835C3.55084 2.58027 3.26146 2.77363 3.0177 3.01738C2.77395 3.26113 2.58059 3.55051 2.44867 3.86899C2.31676 4.18747 2.24886 4.52882 2.24886 4.87354C2.24886 5.21826 2.31676 5.5596 2.44867 5.87808C2.58059 6.19656 2.77395 6.48594 3.0177 6.72969C3.26146 6.97344 3.55084 7.1668 3.86931 7.29872C4.18779 7.43064 4.52914 7.49854 4.87386 7.49854C5.57005 7.49854 6.23773 7.22197 6.73001 6.72969C7.2223 6.23741 7.49886 5.56973 7.49886 4.87354C7.49886 4.17734 7.2223 3.50966 6.73001 3.01738C6.23773 2.5251 5.57005 2.24854 4.87386 2.24854Z" fill="#7F7F88"/></svg>`

    readonly property string authorIconSvg: `<svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M8.5 3.5C8.5 4.88071 7.38071 6 6 6C4.61929 6 3.5 4.88071 3.5 3.5C3.5 2.11929 4.61929 1 6 1C7.38071 1 8.5 2.11929 8.5 3.5Z" stroke-width="1.5" stroke="${darkMode ? '#fafafa' : 'black'}" stroke-opacity="0.6"/><path d="M8.50003 7H8.67603C9.04157 7.0001 9.39449 7.13368 9.66849 7.37564C9.94249 7.6176 10.1187 7.95128 10.164 8.314L10.3595 9.876C10.3771 10.0167 10.3646 10.1596 10.3227 10.2951C10.2809 10.4306 10.2107 10.5556 10.1168 10.6619C10.023 10.7682 9.90758 10.8533 9.77831 10.9116C9.64903 10.9699 9.50884 11 9.36703 11H2.63303C2.49122 11 2.35103 10.9699 2.22175 10.9116C2.09248 10.8533 1.97708 10.7682 1.88322 10.6619C1.78936 10.5556 1.71917 10.4306 1.67733 10.2951C1.63549 10.1596 1.62295 10.0167 1.64053 9.876L1.83553 8.314C1.88088 7.95111 2.05724 7.61729 2.33145 7.37531C2.60565 7.13333 2.95882 6.99986 3.32453 7H3.50003" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" stroke="${darkMode ? '#fafafa' : 'black'}" stroke-opacity="0.6"/></svg>`

    readonly property string sourceIconSvg: `<svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M6 10C6 10 6.75 9.5 8.5 9.5C10.25 9.5 11 10 11 10V3C11 3 10.25 2 8.5 2C6.75 2 6 3 6 3C6 3 5.25 2 3.5 2C1.75 2 1 3 1 3V10C1 10 1.75 9.5 3.5 9.5C5.25 9.5 6 10 6 10ZM6 3V10" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" stroke="${darkMode ? '#fafafa' : 'black'}" stroke-opacity="0.6"/></svg>`

    readonly property string calendarIconSvg: `<svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="1.5" y="2.25" width="9" height="8.25" rx="1" stroke="${darkMode ? '#fafafa' : 'black'}" stroke-opacity="0.6" stroke-width="1.3"/><path d="M1.5 4.75H10.5M4 1.25V2.75M8 1.25V2.75" stroke="${darkMode ? '#fafafa' : 'black'}" stroke-opacity="0.6" stroke-width="1.3" stroke-linecap="round"/></svg>`

    readonly property string databaseIconSvg: `<svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M6 0C3.2875 0 1 1.22 1 2.66667V9.33333C1 10.78 3.2875 12 6 12C8.7125 12 11 10.78 11 9.33333V2.66667C11 1.22 8.7125 0 6 0ZM6 1.33333C8.3 1.33333 9.69375 2.32667 9.75 2.66667C9.69375 3.00667 8.3 4 6 4C3.7 4 2.29375 2.99333 2.25 2.67333C2.29375 2.34 3.69375 1.33333 6 1.33333ZM2.25 4.40667C3.175 4.97333 4.525 5.33333 6 5.33333C7.475 5.33333 8.825 4.96667 9.75 4.40667V6C9.70625 6.33333 8.30625 7.33333 6 7.33333C3.69375 7.33333 2.29375 6.32667 2.25 6V4.40667ZM6 10.6667C3.69375 10.6667 2.29375 9.66 2.25 9.33333V7.74C3.175 8.30667 4.525 8.66667 6 8.66667C7.475 8.66667 8.825 8.3 9.75 7.74V9.33333C9.70625 9.66667 8.30625 10.6667 6 10.6667Z" fill="${darkMode ? '#fafafa' : 'black'}"/></svg>`

    readonly property string chevronIconSvg: `<svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M2 4L6 8L10 4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" stroke="${darkMode ? '#fafafa' : 'black'}" stroke-opacity="0.6"/></svg>`

    readonly property string plusIconSvg: `<svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M9 15V9M9 9V3M9 9H15M9 9H3" stroke-width="2" stroke-linecap="round" stroke="${darkMode ? '#fafafa' : 'black'}" stroke-opacity="0.25"/></svg>`

    // Reusable Input Text component (Node 133:268 / 133:271 / 133:274)
    component QuoteInputRow: Rectangle {
        id: inputRow
        property string iconSvg: ""
        property string placeholder: ""
        property string textValue: ""
        property bool canRemove: false
        signal textEdited(string newText)
        signal addRequested()
        signal removeRequested()

        implicitWidth: 400
        implicitHeight: Math.max(37, Math.ceil(fieldInput.contentHeight) + 20)
        Layout.preferredWidth: 400
        Layout.preferredHeight: implicitHeight
        color: "transparent"
        border.width: 1
        border.color: fieldInput.activeFocus ? root.borderFocus : root.borderInput

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            spacing: 10

            Image {
                Layout.preferredWidth: 12
                Layout.preferredHeight: 12
                Layout.alignment: Qt.AlignVCenter
                source: root.svgDataUri(inputRow.iconSvg)
                sourceSize: Qt.size(24, 24)
                fillMode: Image.PreserveAspectFit
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Text {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: inputRow.placeholder
                    color: root.textPlaceholder
                    font.family: "Inter"
                    font.pixelSize: 12
                    elide: Text.ElideRight
                    visible: fieldInput.text.length === 0
                }

                TextInput {
                    id: fieldInput
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: inputRow.textValue
                    color: root.textPrimary
                    font.family: "Inter"
                    font.pixelSize: 12
                    wrapMode: TextInput.Wrap
                    selectByMouse: true
                    onTextChanged: {
                        if (text !== inputRow.textValue)
                            inputRow.textEdited(text);
                    }
                    Keys.onReturnPressed: function(event) {
                        if (event.modifiers & Qt.ControlModifier) {
                            root.saveQuote();
                        } else {
                            inputRow.addRequested();
                        }
                    }
                    Keys.onPressed: function(event) {
                        if (event.key === Qt.Key_Backspace && text.length === 0 && inputRow.canRemove) {
                            event.accepted = true;
                            inputRow.removeRequested();
                        }
                    }
                }
            }

            Text {
                visible: inputRow.canRemove
                Layout.alignment: Qt.AlignVCenter
                text: "×"
                color: root.textPlaceholder
                font.family: "Inter"
                font.pixelSize: 14

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: inputRow.removeRequested()
                }
            }
        }
    }

    // Reusable Plus button (Node 133:269 / 133:272 / 133:275)
    component PlusButton: Item {
        id: plusBtn
        signal clicked()

        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: 18
        Layout.preferredHeight: 18

        Image {
            anchors.fill: parent
            source: root.svgDataUri(root.plusIconSvg)
            sourceSize: Qt.size(36, 36)
            opacity: plusMouse.containsMouse ? 0.75 : 1.0

            Behavior on opacity {
                NumberAnimation { duration: 120 }
            }
        }

        MouseArea {
            id: plusMouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: plusBtn.clicked()
        }
    }

    // Outer Frame (Node 133:264 "Quote Maker": 472x444, cornerRadius 5, padding 10)
    Rectangle {
        id: outerFrame
        anchors.fill: parent
        implicitWidth: 472
        implicitHeight: innerFrame.implicitHeight + 20
        color: root.bgCanvas
        radius: 5

        // Inner Frame (Node 133:265 "Frame 1635": 452x424, 1px stroke, padding 25, spacing 10)
        Rectangle {
            id: innerFrame
            anchors.fill: parent
            anchors.margins: 10
            implicitWidth: 452
            implicitHeight: mainColumn.implicitHeight + 50
            color: "transparent"
            border.width: 1
            border.color: root.borderOuter

            ColumnLayout {
                id: mainColumn
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 25
                spacing: 10

                // Header Frame (Node 133:266: width 400, height 44, paddingBottom 16)
                Item {
                    Layout.preferredWidth: 400
                    Layout.preferredHeight: 44
                    Layout.alignment: Qt.AlignHCenter

                    Text {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        text: "Quote Maker"
                        color: root.textPrimary
                        font.family: "Gued"
                        font.pixelSize: 24
                        font.bold: true
                    }

                    Text {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        visible: root.statusMessage.length > 0
                        text: root.statusMessage
                        color: root.statusIsError ? root.statusError : root.statusSuccess
                        font.family: "Inter"
                        font.pixelSize: 11
                    }
                }

                // 1. Quotations section (Node 133:268 + 133:269) -> --words list<string>
                Repeater {
                    model: quotationsModel
                    delegate: QuoteInputRow {
                        required property int index
                        required property string value
                        Layout.alignment: Qt.AlignHCenter
                        iconSvg: root.searchIconSvg
                        placeholder: root.ordinal(index + 1) + " quotation"
                        textValue: value
                        canRemove: quotationsModel.count > 1
                        onTextEdited: function(newText) {
                            quotationsModel.setProperty(index, "value", newText);
                        }
                        onAddRequested: quotationsModel.append({ value: "" })
                        onRemoveRequested: quotationsModel.remove(index)
                    }
                }

                PlusButton {
                    onClicked: quotationsModel.append({ value: "" })
                }

                // 2. Authors section (Node 133:271 + 133:272) -> --authors list<string>
                Repeater {
                    model: authorsModel
                    delegate: QuoteInputRow {
                        required property int index
                        required property string value
                        Layout.alignment: Qt.AlignHCenter
                        iconSvg: root.authorIconSvg
                        placeholder: root.ordinal(index + 1) + " author"
                        textValue: value
                        canRemove: authorsModel.count > 1
                        onTextEdited: function(newText) {
                            authorsModel.setProperty(index, "value", newText);
                        }
                        onAddRequested: authorsModel.append({ value: "" })
                        onRemoveRequested: authorsModel.remove(index)
                    }
                }

                PlusButton {
                    onClicked: authorsModel.append({ value: "" })
                }

                // 3. Sources section (Node 133:274 + 133:275) -> --sources list<string>
                Repeater {
                    model: sourcesModel
                    delegate: QuoteInputRow {
                        required property int index
                        required property string value
                        Layout.alignment: Qt.AlignHCenter
                        iconSvg: root.sourceIconSvg
                        placeholder: root.ordinal(index + 1) + " source"
                        textValue: value
                        canRemove: sourcesModel.count > 1
                        onTextEdited: function(newText) {
                            sourcesModel.setProperty(index, "value", newText);
                        }
                        onAddRequested: sourcesModel.append({ value: "" })
                        onRemoveRequested: sourcesModel.remove(index)
                    }
                }

                PlusButton {
                    onClicked: sourcesModel.append({ value: "" })
                }

                // 4. Optional Date field -> --time (YYYY-MM-DD)
                QuoteInputRow {
                    Layout.alignment: Qt.AlignHCenter
                    iconSvg: root.calendarIconSvg
                    placeholder: "Date (YYYY-MM-DD, optional)"
                    textValue: root.quoteTime
                    canRemove: false
                    onTextEdited: function(newText) {
                        root.quoteTime = newText;
                    }
                }

                // 5. Database Select (Node 133:277: 400x37) -> --database
                Rectangle {
                    id: selectBox
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 400
                    Layout.preferredHeight: 37
                    color: "transparent"
                    border.width: 1
                    border.color: root.databaseMenuOpen ? root.borderFocus : root.borderInput
                    z: 10

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        spacing: 10

                        Image {
                            Layout.preferredWidth: 12
                            Layout.preferredHeight: 12
                            source: root.svgDataUri(root.databaseIconSvg)
                            sourceSize: Qt.size(24, 24)
                            fillMode: Image.PreserveAspectFit
                        }

                        Text {
                            Layout.fillWidth: true
                            text: root.databases[root.selectedDatabaseIndex].label
                            color: root.textPrimary
                            font.family: "Inter"
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                        }

                        Image {
                            Layout.preferredWidth: 12
                            Layout.preferredHeight: 12
                            source: root.svgDataUri(root.chevronIconSvg)
                            sourceSize: Qt.size(24, 24)
                            fillMode: Image.PreserveAspectFit
                            rotation: root.databaseMenuOpen ? 180 : 0

                            Behavior on rotation {
                                NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.databaseMenuOpen = !root.databaseMenuOpen
                    }

                    // Dropdown list of databases in /home/terra/storage/desktop/quotes/
                    Rectangle {
                        visible: root.databaseMenuOpen
                        anchors.top: parent.bottom
                        anchors.topMargin: 2
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: dbCol.implicitHeight + 2
                        color: root.bgCanvas
                        border.width: 1
                        border.color: root.borderInput

                        ColumnLayout {
                            id: dbCol
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.margins: 1
                            spacing: 0

                            Repeater {
                                model: root.databases
                                delegate: Rectangle {
                                    required property int index
                                    required property var modelData
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 30
                                    color: itemMouse.containsMouse ? root.brandBlueSoft : "transparent"

                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.leftMargin: 32
                                        anchors.rightMargin: 10

                                        Text {
                                            Layout.fillWidth: true
                                            text: modelData.label
                                            color: root.textPrimary
                                            font.family: "Inter"
                                            font.pixelSize: 12
                                            font.bold: index === root.selectedDatabaseIndex
                                        }

                                        Text {
                                            text: modelData.label.toLowerCase() + ".json"
                                            color: root.textPlaceholder
                                            font.family: "Inter"
                                            font.pixelSize: 10
                                        }
                                    }

                                    MouseArea {
                                        id: itemMouse
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            root.selectedDatabaseIndex = index;
                                            root.databaseMenuOpen = false;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // 6. Footer Buttons Row (Node 133:278: width 400, height 46, paddingTop 16, paddingBottom 5, paddingLeft/Right 5)
                Item {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 400
                    Layout.preferredHeight: 46

                    // Save Button (Node 133:279: 125x25, cornerRadius 5, fill #171717)
                    Rectangle {
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        anchors.top: parent.top
                        anchors.topMargin: 16
                        width: 125
                        height: 25
                        radius: 5
                        color: root.actionPrimaryBg
                        opacity: saveProcess.running ? 0.5 : (saveMouse.pressed ? 0.85 : (saveMouse.containsMouse ? 0.92 : 1.0))

                        Text {
                            anchors.centerIn: parent
                            text: saveProcess.running ? "Saving..." : "Save"
                            color: root.actionPrimaryFg
                            font.family: "Inter"
                            font.pixelSize: 12
                            font.bold: true
                        }

                        MouseArea {
                            id: saveMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.saveQuote()
                        }
                    }

                    // Cancel Button (Node 133:280: 125x25, cornerRadius 5, fill #60cdea @ 25%, text #60cdea)
                    Rectangle {
                        anchors.right: parent.right
                        anchors.rightMargin: 5
                        anchors.top: parent.top
                        anchors.topMargin: 16
                        width: 125
                        height: 25
                        radius: 5
                        color: cancelMouse.pressed
                            ? Qt.rgba(96 / 255, 205 / 255, 234 / 255, 0.35)
                            : (cancelMouse.containsMouse
                                ? Qt.rgba(96 / 255, 205 / 255, 234 / 255, 0.30)
                                : root.brandBlueSoft)

                        Text {
                            anchors.centerIn: parent
                            text: "Cancel"
                            color: root.brandBlue
                            font.family: "Inter"
                            font.pixelSize: 12
                            font.bold: true
                        }

                        MouseArea {
                            id: cancelMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                root.statusMessage = "";
                                root.resetForm();
                            }
                        }
                    }
                }
            }
        }
    }
}
