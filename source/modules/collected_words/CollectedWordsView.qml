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
                model: quotationsModel
                delegate: QuoteInputRow {
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
                    onAddRequested: quotationsModel.append({ value: "" })
                    onRemoveRequested: quotationsModel.remove(index)
                    onSaveRequested: root.submitQuote()
                }
            }

            // 2. Authors section (Node 133:271 "Input Text", Type="With action")
            Repeater {
                model: authorsModel
                delegate: QuoteInputRow {
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
                    onAddRequested: authorsModel.append({ value: "" })
                    onRemoveRequested: authorsModel.remove(index)
                    onSaveRequested: root.submitQuote()
                }
            }

            // 3. Sources section (Node 133:274 "Input Text", Type="With action")
            Repeater {
                model: sourcesModel
                delegate: QuoteInputRow {
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
                    onAddRequested: sourcesModel.append({ value: "" })
                    onRemoveRequested: sourcesModel.remove(index)
                    onSaveRequested: root.submitQuote()
                }
            }

            // 4. Date field (Node 136:329 "Input Text", Type="Default")
            QuoteInputRow {
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
            }

            // 5. Database Select Dropdown (Node 133:277 "Input Select")
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

            // 6. Footer Buttons Row (Node 133:278 "Frame 1636": width 400, height 46, space between)
            Item {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 400
                Layout.preferredHeight: 46

                // Save button (Node 133:279: 125x25, cornerRadius 5, fill actionPrimaryBg)
                Controls.Button {
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
                }

                // Cancel / Destructive button (Node 133:280: 125x25, cornerRadius 5, variant Destructive)
                Controls.Button {
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
                }
            }
        }
    }
}
