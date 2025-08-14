// MetricList.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Flickable {
    id: root
    property real mySpacing: 8.0
    property var model
    property int selectedId: -1
    signal metricSelected(int metricId)

    Layout.fillWidth: true
    Layout.fillHeight: true
    clip: true
    interactive: true
    boundsBehavior: Flickable.StopAtBounds

    Rectangle {
        anchors.fill: parent
        color: "#FFFFFF"
        z: -1
    }

    MouseArea {
        anchors.fill: parent
        z: 0
        onClicked: {
            root.selectedId = -1
            root.metricSelected(-1)
        }
    }

    Flow {
        id: flow
        width: root.width
        spacing: mySpacing * 2
        anchors.top: parent.top
        anchors.left: parent.left

        property int columns: 2
        property real cellWidth: Math.floor((width - (columns - 1) * spacing) / columns)

        Repeater {
            model: root.model
            delegate: MetricCard {
                width: flow.cellWidth
                mySpacing: root.mySpacing
                idMetric: modelData.id
                date: modelData.date
                name: modelData.name
                rating: modelData.rating
                onCardClicked: {
                    root.selectedId = idMetric
                    root.metricSelected(idMetric)
                }
            }
        }

        Item {
            visible: model.length === 0
            width: flow.width - flow.spacing
            height: 120
            RowLayout {
                anchors.fill: parent
                anchors.margins: mySpacing * 2
                Text {
                    text: "Пока нет метрик..."
                    Layout.alignment: Qt.AlignHCenter
                    font.pixelSize: 14
                    color: "#888"
                }
            }
        }
    }

    contentHeight: flow.implicitHeight
    contentWidth: flow.width
}

