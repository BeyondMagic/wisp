import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services
import qs.utils
import qs.components.controls as Controls

Rectangle {
    id: root

    property bool editMode: false

    property alias quotationsModel: quotationsModel
    property alias authorsModel: authorsModel
    property alias sourcesModel: sourcesModel
    property alias databaseDropdown: databaseDropdown

    implicitWidth: 472
    implicitHeight: innerFrame.implicitHeight + 20
    color: Theme.bgCanvas
    radius: 5

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

    function ordinal(n) {
        const s = ["th", "st", "nd", "rd"];
        const v = n % 100;
        return n + (s[(v - 20) % 10] || s[v] || s[0]);
    }

    function addQuotation() {
        quotationsModel.append({ value: "" });
        Qt.callLater(function() {
            const item = quotationsRepeater.itemAt(quotationsModel.count - 1);
            if (item) item.forceActiveFocus("down");
        });
    }

    function removeQuotation(index) {
        if (quotationsModel.count > 1) {
            const focusIdx = Math.max(0, index - 1);
            quotationsModel.remove(index);
            Qt.callLater(function() {
                const item = quotationsRepeater.itemAt(focusIdx);
                if (item) item.forceActiveFocus("up");
            });
        }
    }

    function addAuthor() {
        authorsModel.append({ value: "" });
        Qt.callLater(function() {
            const item = authorsRepeater.itemAt(authorsModel.count - 1);
            if (item) item.forceActiveFocus("down");
        });
    }

    function removeAuthor(index) {
        if (authorsModel.count > 1) {
            const focusIdx = Math.max(0, index - 1);
            authorsModel.remove(index);
            Qt.callLater(function() {
                const item = authorsRepeater.itemAt(focusIdx);
                if (item) item.forceActiveFocus("up");
            });
        }
    }

    function addSource() {
        sourcesModel.append({ value: "" });
        Qt.callLater(function() {
            const item = sourcesRepeater.itemAt(sourcesModel.count - 1);
            if (item) item.forceActiveFocus("down");
        });
    }

    function removeSource(index) {
        if (sourcesModel.count > 1) {
            const focusIdx = Math.max(0, index - 1);
            sourcesModel.remove(index);
            Qt.callLater(function() {
                const item = sourcesRepeater.itemAt(focusIdx);
                if (item) item.forceActiveFocus("up");
            });
        }
    }

    function getFocusChain() {
        const list = [];
        for (let i = 0; i < quotationsRepeater.count; i++) {
            const item = quotationsRepeater.itemAt(i);
            if (item) list.push(item);
        }
        for (let i = 0; i < authorsRepeater.count; i++) {
            const item = authorsRepeater.itemAt(i);
            if (item) list.push(item);
        }
        for (let i = 0; i < sourcesRepeater.count; i++) {
            const item = sourcesRepeater.itemAt(i);
            if (item) list.push(item);
        }
        if (dateRow) list.push(dateRow);
        if (databaseDropdown) list.push(databaseDropdown);
        if (saveButton) list.push(saveButton);
        if (cancelButton) list.push(cancelButton);
        return list;
    }

    function focusNext(fromItem) {
        const chain = getFocusChain();
        const idx = chain.indexOf(fromItem);
        if (idx >= 0) {
            const nextIdx = (idx + 1) % chain.length;
            chain[nextIdx].forceActiveFocus("down");
        } else if (chain.length > 0) {
            chain[0].forceActiveFocus("down");
        }
    }

    function focusPrev(fromItem) {
        const chain = getFocusChain();
        const idx = chain.indexOf(fromItem);
        if (idx >= 0) {
            const prevIdx = (idx - 1 + chain.length) % chain.length;
            chain[prevIdx].forceActiveFocus("up");
        } else if (chain.length > 0) {
            chain[chain.length - 1].forceActiveFocus("up");
        }
    }

    function navigateArrowDown(fromItem) {
        const chain = getFocusChain();
        const idx = chain.indexOf(fromItem);
        if (idx >= 0 && idx < chain.length - 1) {
            if (fromItem === saveButton || fromItem === cancelButton) {
                return;
            }
            chain[idx + 1].forceActiveFocus("down");
        }
    }

    function navigateArrowUp(fromItem) {
        const chain = getFocusChain();
        const idx = chain.indexOf(fromItem);
        if (idx > 0) {
            if (fromItem === cancelButton) {
                databaseDropdown.forceActiveFocus();
                return;
            }
            chain[idx - 1].forceActiveFocus("up");
        }
    }

    Component.onCompleted: {
        Qt.callLater(function() {
            const first = quotationsRepeater.itemAt(0);
            if (first) first.forceActiveFocus();
        });
    }

    function resetForm() {
        quotationsModel.clear();
        quotationsModel.append({ value: "" });
        authorsModel.clear();
        authorsModel.append({ value: "" });
        sourcesModel.clear();
        sourcesModel.append({ value: "" });
        quoteTime = "";
        Qt.callLater(function() {
            const first = quotationsRepeater.itemAt(0);
            if (first) first.forceActiveFocus();
        });
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

    function submitQuote() {
        const words = collectNonEmpty(quotationsModel);
        if (words.length === 0) {
            QuotesService.statusIsError = true;
            QuotesService.statusMessage = "Enter at least 1 quotation line.";
            return;
        }

        const currentDb = QuotesService.databases[QuotesService.selectedDatabaseIndex];
        const payload = {
            words: words,
            authors: collectNonEmpty(authorsModel),
            sources: collectNonEmpty(sourcesModel),
            time: quoteTime.trim(),
            database: currentDb.path
        };

        QuotesService.saveQuote(payload);
    }

    Connections {
        target: QuotesService
        function onSaveSucceeded(dbLabel) {
            root.resetForm();
        }
    }

    // Inner frame border (Node 133:265 "Frame 1635": 452x387, 1px stroke, padding 25, spacing 10)
    Rectangle {
        id: innerFrame
        anchors.fill: parent
        anchors.margins: 10
        implicitWidth: 452
        implicitHeight: mainColumn.implicitHeight + 50
        color: "transparent"
        border.width: 1
        border.color: Theme.borderOuter

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
                    text: root.editMode ? "Edit quote" : "Save a quote"
                    color: Theme.textPrimary
                    font.family: Theme.fontDisplay
                    font.pixelSize: 24
                    font.bold: true
                }

                Text {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    visible: QuotesService.statusMessage.length > 0
                    text: QuotesService.statusMessage
                    color: QuotesService.statusIsError ? Theme.statusError : Theme.statusSuccess
                    font.family: Theme.fontSans
                    font.pixelSize: 11
                }
            }

            // 1. Quotations section (Node 133:268 "Input Text", Type="With action")
            Repeater {
                id: quotationsRepeater
                model: quotationsModel
                delegate: QuoteInputRow {
                    id: quoteRow
                    required property int index
                    required property string value
                    Layout.alignment: Qt.AlignHCenter
                    withAction: true
                    iconSvg: Icons.search(Theme.iconSubtle)
                    placeholder: root.ordinal(index + 1) + " quotation"
                    textValue: value
                    canRemove: quotationsModel.count > 1
                    onTextEdited: function(newText) {
                        quotationsModel.setProperty(index, "value", newText);
                    }
                    onAddRequested: root.addQuotation()
                    onRemoveRequested: root.removeQuotation(index)
                    onSaveRequested: root.submitQuote()
                    onNavigateNext: root.focusNext(quoteRow)
                    onNavigatePrev: root.focusPrev(quoteRow)
                    onNavigateDown: root.navigateArrowDown(quoteRow)
                    onNavigateUp: root.navigateArrowUp(quoteRow)
                }
            }

            // 2. Authors section (Node 133:271 "Input Text", Type="With action")
            Repeater {
                id: authorsRepeater
                model: authorsModel
                delegate: QuoteInputRow {
                    id: authorRow
                    required property int index
                    required property string value
                    Layout.alignment: Qt.AlignHCenter
                    withAction: true
                    iconSvg: Icons.author(Theme.textPrimary, 0.6)
                    placeholder: root.ordinal(index + 1) + " author"
                    textValue: value
                    canRemove: authorsModel.count > 1
                    onTextEdited: function(newText) {
                        authorsModel.setProperty(index, "value", newText);
                    }
                    onAddRequested: root.addAuthor()
                    onRemoveRequested: root.removeAuthor(index)
                    onSaveRequested: root.submitQuote()
                    onNavigateNext: root.focusNext(authorRow)
                    onNavigatePrev: root.focusPrev(authorRow)
                    onNavigateDown: root.navigateArrowDown(authorRow)
                    onNavigateUp: root.navigateArrowUp(authorRow)
                }
            }

            // 3. Sources section (Node 133:274 "Input Text", Type="With action")
            Repeater {
                id: sourcesRepeater
                model: sourcesModel
                delegate: QuoteInputRow {
                    id: sourceRow
                    required property int index
                    required property string value
                    Layout.alignment: Qt.AlignHCenter
                    withAction: true
                    iconSvg: Icons.source(Theme.textPrimary, 0.6)
                    placeholder: root.ordinal(index + 1) + " source"
                    textValue: value
                    canRemove: sourcesModel.count > 1
                    onTextEdited: function(newText) {
                        sourcesModel.setProperty(index, "value", newText);
                    }
                    onAddRequested: root.addSource()
                    onRemoveRequested: root.removeSource(index)
                    onSaveRequested: root.submitQuote()
                    onNavigateNext: root.focusNext(sourceRow)
                    onNavigatePrev: root.focusPrev(sourceRow)
                    onNavigateDown: root.navigateArrowDown(sourceRow)
                    onNavigateUp: root.navigateArrowUp(sourceRow)
                }
            }

            // 4. Date field (Node 136:329 "Input Text", Type="Default")
            QuoteInputRow {
                id: dateRow
                Layout.alignment: Qt.AlignHCenter
                withAction: false
                iconSvg: Icons.calendar(Theme.textPrimary, 0.6)
                placeholder: "Date (YYYY-MM-DD, optional)"
                textValue: root.quoteTime
                canRemove: false
                onTextEdited: function(newText) {
                    root.quoteTime = newText;
                }
                onSaveRequested: root.submitQuote()
                onNavigateNext: root.focusNext(dateRow)
                onNavigatePrev: root.focusPrev(dateRow)
                onNavigateDown: root.navigateArrowDown(dateRow)
                onNavigateUp: root.navigateArrowUp(dateRow)
            }

            // 5. Database Select Dropdown (Node 133:277 "Input Select")
            Controls.Dropdown {
                id: databaseDropdown
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 400
                model: QuotesService.databases
                selectedIndex: QuotesService.selectedDatabaseIndex
                leadingIconSvg: Icons.database(Theme.textPrimary)
                itemTextProperty: "label"
                onSelected: function(idx, item) {
                    QuotesService.selectedDatabaseIndex = idx;
                }
                onNavigateNext: root.focusNext(databaseDropdown)
                onNavigatePrev: root.focusPrev(databaseDropdown)
                onNavigateDown: saveButton.forceActiveFocus()
                onNavigateUp: dateRow.forceActiveFocus("up")
            }

            // 6. Footer Buttons Row (Node 133:278 "Frame 1636": width 400, height 46, space between)
            Item {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 400
                Layout.preferredHeight: 46

                // Save button (Node 133:279: 125x25, cornerRadius 5, fill actionPrimaryBg)
                Controls.Button {
                    id: saveButton
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    implicitWidth: 125
                    implicitHeight: 25
                    radiusSize: 5
                    text: QuotesService.saving ? "Saving..." : (root.editMode ? "Save changes" : "Save")
                    variant: "primary"
                    loading: QuotesService.saving
                    onClicked: root.submitQuote()
                    onNavigateNext: root.focusNext(saveButton)
                    onNavigatePrev: root.focusPrev(saveButton)
                    onNavigateRight: cancelButton.forceActiveFocus()
                    onNavigateUp: databaseDropdown.forceActiveFocus()
                }

                // Cancel / Destructive button (Node 133:280: 125x25, cornerRadius 5, variant Destructive)
                Controls.Button {
                    id: cancelButton
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    implicitWidth: 125
                    implicitHeight: 25
                    radiusSize: 5
                    text: root.editMode ? "Delete quote" : "Cancel"
                    variant: "destructive"
                    onClicked: {
                        QuotesService.statusMessage = "";
                        root.resetForm();
                    }
                    onNavigateNext: root.focusNext(cancelButton)
                    onNavigatePrev: root.focusPrev(cancelButton)
                    onNavigateLeft: saveButton.forceActiveFocus()
                    onNavigateUp: databaseDropdown.forceActiveFocus()
                }
            }
        }
    }
}
