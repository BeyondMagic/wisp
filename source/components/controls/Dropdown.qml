import QtQuick
import QtQuick.Layouts
import qs.config
import qs.utils

Item {
    id: root

    property var model: []
    property int selectedIndex: 0
    property string leadingIconSvg: ""
    property string itemTextProperty: "label"
    property bool isOpen: false

    signal selected(int index, var item)

    implicitWidth: 400
    implicitHeight: 37
    z: isOpen ? 100 : 1

    readonly property var currentItem: (model && selectedIndex >= 0 && selectedIndex < model.length) ? model[selectedIndex] : null
    readonly property string currentLabel: {
        if (!currentItem)
            return "";
        if (typeof currentItem === "string")
            return currentItem;
        return currentItem[itemTextProperty] || "";
    }

    // Trigger button
    Rectangle {
        id: triggerBox
        anchors.left: parent.left
        anchors.right: parent.right
        height: 37
        color: "transparent"
        border.width: 1
        border.color: root.isOpen ? Theme.borderFocus : Theme.borderInput

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            spacing: 10

            Image {
                visible: root.leadingIconSvg.length > 0
                Layout.preferredWidth: 12
                Layout.preferredHeight: 12
                Layout.alignment: Qt.AlignVCenter
                source: root.leadingIconSvg.length > 0 ? Icons.dataUri(root.leadingIconSvg) : ""
                sourceSize: Qt.size(24, 24)
                fillMode: Image.PreserveAspectFit
            }

            Text {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                text: root.currentLabel
                color: Theme.textPrimary
                font.family: Theme.fontSans
                font.pixelSize: 12
                elide: Text.ElideRight
            }

            Image {
                Layout.preferredWidth: 12
                Layout.preferredHeight: 12
                Layout.alignment: Qt.AlignVCenter
                source: Icons.dataUri(Icons.chevron(Theme.textPrimary, 0.6))
                sourceSize: Qt.size(24, 24)
                fillMode: Image.PreserveAspectFit
                rotation: root.isOpen ? 180 : 0
                Behavior on rotation {
                    NumberAnimation { duration: 150 }
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                root.isOpen = !root.isOpen;
            }
        }
    }

    // Dropdown popup
    Rectangle {
        id: menuPopup
        visible: root.isOpen
        anchors.top: triggerBox.bottom
        anchors.topMargin: 4
        anchors.left: parent.left
        anchors.right: parent.right
        implicitHeight: optionsColumn.implicitHeight + 8
        color: Theme.bgSurface
        border.width: 1
        border.color: Theme.borderInput
        z: 1000

        Column {
            id: optionsColumn
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 4

            Repeater {
                model: root.model

                delegate: Rectangle {
                    id: delegateItem
                    width: optionsColumn.width
                    height: 32
                    color: itemArea.containsMouse ? Qt.rgba(Theme.textPrimary.r, Theme.textPrimary.g, Theme.textPrimary.b, 0.08) : "transparent"

                    readonly property var rawData: modelData
                    readonly property string labelText: {
                        if (typeof rawData === "string")
                            return rawData;
                        return rawData[root.itemTextProperty] || "";
                    }

                    Text {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        anchors.verticalCenter: parent.verticalCenter
                        text: delegateItem.labelText
                        color: index === root.selectedIndex ? Theme.accentBlue : Theme.textPrimary
                        font.family: Theme.fontSans
                        font.pixelSize: 12
                        font.weight: index === root.selectedIndex ? Font.DemiBold : Font.Normal
                        elide: Text.ElideRight
                    }

                    MouseArea {
                        id: itemArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            root.selectedIndex = index;
                            root.isOpen = false;
                            root.selected(index, rawData);
                        }
                    }
                }
            }
        }
    }

    function close() {
        isOpen = false;
    }

    function toggle() {
        isOpen = !isOpen;
    }
}

