import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services
import qs.utils
import qs.components.controls as Controls

Rectangle {
    id: root

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

    function resetForm() {
        quotationsModel.clear();
        quotationsModel.append({ value: "" });
        authorsModel.clear();
        authorsModel.append({ value: "" });
        sourcesModel.clear();
        sourcesModel.append({ value: "" });
        quoteTime = "";
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

    // Inner frame border
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

            // Header Frame
            Item {
                Layout.preferredWidth: 400
                Layout.preferredHeight: 44
                Layout.alignment: Qt.AlignHCenter

                Text {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    text: "Save a quote"
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

            // 1. Quotations section
            Repeater {
                model: quotationsModel
                delegate: QuoteInputRow {
                    required property int index
                    required property string value
                    Layout.alignment: Qt.AlignHCenter
                    iconSvg: Icons.search(Theme.textPrimary)
                    placeholder: root.ordinal(index + 1) + " quotation"
                    textValue: value
                    canRemove: quotationsModel.count > 1
                    onTextEdited: function(newText) {
                        quotationsModel.setProperty(index, "value", newText);
                    }
                    onAddRequested: quotationsModel.append({ value: "" })
                    onRemoveRequested: quotationsModel.remove(index)
                    onSaveRequested: root.submitQuote()
                }
            }

            // Plus button for quotations
            Controls.Button {
                Layout.alignment: Qt.AlignHCenter
                variant: "icon"
                iconSvg: Icons.plus(Theme.textPrimary, 0.25)
                implicitWidth: 18
                implicitHeight: 18
                paddingHorizontal: 0
                paddingVertical: 0
                onClicked: quotationsModel.append({ value: "" })
            }

            // 2. Authors section
            Repeater {
                model: authorsModel
                delegate: QuoteInputRow {
                    required property int index
                    required property string value
                    Layout.alignment: Qt.AlignHCenter
                    iconSvg: Icons.author(Theme.textPrimary, 0.6)
                    placeholder: root.ordinal(index + 1) + " author"
                    textValue: value
                    canRemove: authorsModel.count > 1
                    onTextEdited: function(newText) {
                        authorsModel.setProperty(index, "value", newText);
                    }
                    onAddRequested: authorsModel.append({ value: "" })
                    onRemoveRequested: authorsModel.remove(index)
                    onSaveRequested: root.submitQuote()
                }
            }

            // Plus button for authors
            Controls.Button {
                Layout.alignment: Qt.AlignHCenter
                variant: "icon"
                iconSvg: Icons.plus(Theme.textPrimary, 0.25)
                implicitWidth: 18
                implicitHeight: 18
                paddingHorizontal: 0
                paddingVertical: 0
                onClicked: authorsModel.append({ value: "" })
            }

            // 3. Sources section
            Repeater {
                model: sourcesModel
                delegate: QuoteInputRow {
                    required property int index
                    required property string value
                    Layout.alignment: Qt.AlignHCenter
                    iconSvg: Icons.source(Theme.textPrimary, 0.6)
                    placeholder: root.ordinal(index + 1) + " source"
                    textValue: value
                    canRemove: sourcesModel.count > 1
                    onTextEdited: function(newText) {
                        sourcesModel.setProperty(index, "value", newText);
                    }
                    onAddRequested: sourcesModel.append({ value: "" })
                    onRemoveRequested: sourcesModel.remove(index)
                    onSaveRequested: root.submitQuote()
                }
            }

            // Plus button for sources
            Controls.Button {
                Layout.alignment: Qt.AlignHCenter
                variant: "icon"
                iconSvg: Icons.plus(Theme.textPrimary, 0.25)
                implicitWidth: 18
                implicitHeight: 18
                paddingHorizontal: 0
                paddingVertical: 0
                onClicked: sourcesModel.append({ value: "" })
            }

            // 4. Date field
            QuoteInputRow {
                Layout.alignment: Qt.AlignHCenter
                iconSvg: Icons.calendar(Theme.textPrimary, 0.6)
                placeholder: "Date (YYYY-MM-DD, optional)"
                textValue: root.quoteTime
                canRemove: false
                onTextEdited: function(newText) {
                    root.quoteTime = newText;
                }
                onSaveRequested: root.submitQuote()
            }

            // 5. Database Select Dropdown
            Controls.Dropdown {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 400
                model: QuotesService.databases
                selectedIndex: QuotesService.selectedDatabaseIndex
                leadingIconSvg: Icons.database(Theme.textPrimary)
                itemTextProperty: "label"
                onSelected: function(idx, item) {
                    QuotesService.selectedDatabaseIndex = idx;
                }
            }

            // 6. Footer Buttons Row
            Item {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 400
                Layout.preferredHeight: 46

                // Save button
                Controls.Button {
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    implicitWidth: 125
                    implicitHeight: 25
                    radiusSize: 5
                    text: QuotesService.saving ? "Saving..." : "Save"
                    variant: "primary"
                    loading: QuotesService.saving
                    onClicked: root.submitQuote()
                }

                // Cancel button
                Controls.Button {
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    implicitWidth: 125
                    implicitHeight: 25
                    radiusSize: 5
                    text: "Cancel"
                    variant: "secondary"
                    onClicked: {
                        QuotesService.statusMessage = "";
                        root.resetForm();
                    }
                }
            }
        }
    }
}

