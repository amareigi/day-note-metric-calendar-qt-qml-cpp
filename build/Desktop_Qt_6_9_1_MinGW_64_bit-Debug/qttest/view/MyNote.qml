// MyNote.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    property real mySpacing: 8.0

    ColumnLayout {
        anchors.fill: parent
        spacing: mySpacing

        // -----------------------
        // Панель кнопок (без изменений)
        // -----------------------
        RowLayout {
            Layout.fillWidth: true
            spacing: mySpacing * 2
            Layout.preferredHeight: parent.height * 0.08
            Layout.fillHeight: false

            Button {
                id: newButton
                text: "Новая заметка"
                Layout.fillWidth: true
                Layout.fillHeight: true
                onClicked: {
                    noteInput.visible = true
                    noteInput.focus = true
                    noteInput.text = ""
                    saveButton.enabled = true
                }
            }

            Button {
                id: saveButton
                text: "Сохранить"
                Layout.fillWidth: true
                Layout.fillHeight: true
                enabled: false
                onClicked: {
                    if (noteInput.text.trim() !== "") {
                        controller.addNote(noteInput.text)
                        noteInput.visible = false
                        saveButton.enabled = false
                    }
                }
            }

            Button {
                id: deleteButton
                text: "Удалить"
                Layout.fillWidth: true
                Layout.fillHeight: true
                onClicked: controller.removeLastNote()
            }
        }

        // -----------------------
        // Поле ввода
        // -----------------------
        TextField {
            id: noteInput
            Layout.fillWidth: true
            visible: false
            placeholderText: "Введите новую заметку..."
            onTextChanged: saveButton.enabled = (text.trim() !== "")
            Keys.onEnterPressed: saveButton.clicked()
            Keys.onReturnPressed: saveButton.clicked()
        }

        // -----------------------
        // Список заметок: Flickable + Flow
        // -----------------------
        Flickable {
            id: flick
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

            Flow {
                id: flow
                width: flick.width
                spacing: mySpacing * 2
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: mySpacing * 2

                property int columns: 2
                property real cellWidth: Math.floor((width - (columns - 1) * spacing) / columns)

                Repeater {
                    model: controller.filteredNotes
                    delegate: Rectangle {
                        width: flow.cellWidth
                        color: "#E6F0FA"
                        radius: 6
                        border.width: 1
                        border.color: "#cccccc"

                        ColumnLayout {
                            id: card
                            anchors.fill: parent
                            anchors.margins: mySpacing * 1.25
                            spacing: mySpacing

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: mySpacing

                                Text {
                                    text: "\u270D"
                                    font.pixelSize: 18
                                    color: "#444"
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 2

                                    Text {
                                        id: noteDate
                                        text: modelData.date
                                        font.pixelSize: 12
                                        color: "#777"
                                    }

                                    Text {
                                        id: noteContent
                                        text: modelData.content
                                        font.pixelSize: 14
                                        wrapMode: Text.WordWrap
                                        Layout.fillWidth: true
                                    }
                                }
                            }
                        }

                        implicitHeight: Math.max(64, card.implicitHeight + mySpacing * 2)
                    }
                }

                Item {
                    visible: controller.filteredNotes.length === 0
                    width: flow.width - flow.spacing
                    height: 120
                    Row {
                        anchors.fill: parent
                        anchors.margins: mySpacing * 2
                        Text {
                            text: "Пока нет заметок..."
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 14
                            color: "#888"
                        }
                    }
                }
            }

            contentHeight: flow.implicitHeight + (flow.anchors.margins ? flow.anchors.margins : 0)
            contentWidth: flow.width
        }
    }

    Connections {
        target: controller
        onFilteredNotesChanged: {
            console.log("Изменено количество отфильтрованных заметок:", controller.filteredNotes.length)
        }
    }
}
