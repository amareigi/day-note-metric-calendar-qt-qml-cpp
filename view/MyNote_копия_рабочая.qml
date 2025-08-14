// MyNote.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    property real mySpacing: 5.0

    ColumnLayout {
        anchors.fill: parent
        spacing: mySpacing

        // Панель кнопок
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

        // Поле ввода новой заметки
        TextField {
            id: noteInput
            Layout.fillWidth: true
            visible: false
            placeholderText: "Введите новую заметку..."
            onTextChanged: saveButton.enabled = (text.trim() !== "")
            Keys.onEnterPressed: saveButton.clicked()
            Keys.onReturnPressed: saveButton.clicked()
        }

        // Список заметок
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            background: Rectangle { color: "#FFFFFF" }

            Column {
                id: notesContainer
                width: parent.width
                spacing: mySpacing * 2

                Repeater {
                    model: controller.filteredNotes
                    delegate: Rectangle {
                        width: notesContainer.width // ✅ теперь всегда растягивается
                        height: Math.max(60, noteContent.implicitHeight + 20)
                        color: "#E6F0FA"
                        radius: 5
                        border.width: 1
                        border.color: "black"

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: mySpacing * 2
                            spacing: mySpacing * 2

                            Text {
                                text: "\u270D"
                                font.pixelSize: 20
                                color: "#555"
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: mySpacing

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
                                    wrapMode: Text.Wrap
                                    Layout.fillWidth: true
                                }
                            }
                        }
                    }
                }

                Text {
                    visible: controller.filteredNotes.length === 0
                    text: "Пока нет заметок..."
                    font.pixelSize: 14
                    color: "#888"
                    horizontalAlignment: Text.AlignHCenter
                    width: notesContainer.width
                }
            }
        }
    }

    Connections {
        target: controller
        onFilteredNotesChanged: {
            console.log("Изменено количество отфильтрованных заметок:", controller.filteredNotes.length)
        }
    }
}
