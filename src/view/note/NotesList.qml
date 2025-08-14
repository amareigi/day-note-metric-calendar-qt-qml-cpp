// NotesList.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Flickable {
    id: root
    property real mySpacing: 8.0
    property var model

    property int selectedId: -1
    signal noteSelected(int noteId)

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

    // Область для клика в пустое место и сброса selectedId
    MouseArea {
        anchors.fill: parent
        z: 0
        onClicked: {
            root.selectedId = -1
            root.noteSelected(-1)
            console.log("Сброс выбора заметки")
        }
    }

    Flow {
        id: flow
        width: root.width
        spacing: mySpacing * 2
        anchors.top: parent.top
        anchors.left: parent.left
        // anchors.margins: mySpacing * 2

        property int columns: 2
        property real cellWidth: Math.floor((width - (columns - 1) * spacing) / columns)

        Repeater {
            model: root.model
            delegate: NoteCard {
                width: flow.cellWidth
                mySpacing: root.mySpacing
                idNote: modelData.id
                date: modelData.date
                content: modelData.content
                onCardClicked: {
                    root.selectedId = idNote
                    root.noteSelected(idNote)
                    console.log("Выбрана заметка id=", idNote)
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
                    text: "Пока нет заметок..."
                    Layout.alignment: Qt.AlignHCenter
                    font.pixelSize: 14 // адаптивный сделать
                    color: "#888"
                }
            }
        }
    }

    contentHeight: flow.implicitHeight + (flow.anchors.margins ? flow.anchors.margins : 0)
    contentWidth: flow.width
}

