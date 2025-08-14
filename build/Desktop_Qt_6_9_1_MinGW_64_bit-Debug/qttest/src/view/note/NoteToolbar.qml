// NoteToolbar
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: root
    property real mySpacing: 8.0
    signal newNoteRequested()
    signal saveNoteRequested()
    signal deleteNoteRequested(int noteId)
    property int selectedNoteId: -1

    Layout.fillWidth: true
    spacing: mySpacing * 2
    Layout.preferredHeight: parent ? parent.height * 0.08 : 50
    Layout.fillHeight: false

    Button {
        text: "Новая заметка"
        Layout.fillWidth: true
        Layout.fillHeight: true
        onClicked: root.newNoteRequested()
    }

    Button {
        id: saveButton
        text: "Сохранить"
        Layout.fillWidth: true
        Layout.fillHeight: true
        enabled: false
        onClicked: root.saveNoteRequested()
    }

    Button {
        text: "Удалить"
        Layout.fillWidth: true
        Layout.fillHeight: true
        enabled: root.selectedNoteId >= 0
        onClicked: root.deleteNoteRequested(root.selectedNoteId)
    }

    function enableSaveButton(enabled) { saveButton.enabled = enabled }
    function triggerSave() { saveButton.clicked() }
}

