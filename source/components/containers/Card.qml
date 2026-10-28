import QtQuick
import qs.config

Rectangle {
    id: root

    default property alias content: innerContainer.data
    property int padding: 36

    color: Theme.bgCanvas
    border.width: 1
    border.color: Theme.borderOuter

    Item {
        id: innerContainer
        anchors.fill: parent
        anchors.margins: root.padding
    }
}

