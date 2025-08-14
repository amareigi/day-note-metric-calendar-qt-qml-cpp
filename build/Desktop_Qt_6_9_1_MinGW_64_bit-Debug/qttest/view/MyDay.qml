//MyDay.qml
import QtQuick

Rectangle {
    id: root

    property int dayIndex: -1
    property bool isSelected: false
    property real myFontSize: 0.0

    signal dayClicked(int dayIndex)

    border.color: isSelected ? "red" : "black"
    border.width: 1
    color: dayIndex > 0 ? "lightgreen" : "lightgray"

    Text {
        id: txt
        text: root.dayIndex > 0 ? dayIndex.toString() : ""
        anchors.centerIn: parent
        font.pixelSize: Math.min(parent.width * 0.5, parent.height * 0.5)
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (root.dayIndex > 0) {
                root.dayClicked(root.dayIndex);
                console.log("Day:dayClicked, index:", root.dayIndex);
            }
        }

    }
}
