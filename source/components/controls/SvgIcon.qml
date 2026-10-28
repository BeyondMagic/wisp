import QtQuick
import qs.utils

Image {
    id: root

    property string svg: ""

    implicitWidth: 12
    implicitHeight: 12
    sourceSize: Qt.size(width * 2, height * 2)
    fillMode: Image.PreserveAspectFit
    smooth: true
    mipmap: true

    source: svg.length > 0 ? Icons.dataUri(svg) : ""
}

