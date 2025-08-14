// MyNote.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    property real mySpacing: 8.0
    property int selectedNoteId: -1


    ColumnLayout {
        anchors.fill: parent
        spacing: mySpacing

        NoteToolbar {
            id: toolbar
            mySpacing: root.mySpacing
            selectedNoteId: root.selectedNoteId
            onNewNoteRequested: {
                noteInput.visible = true
                noteInput.focus = true
                noteInput.text = ""
                toolbar.enableSaveButton(true)
            }
            onSaveNoteRequested: {
                if (noteInput.text.trim() !== "") {
                    controller.addNote(noteInput.text)
                    noteInput.visible = false
                    toolbar.enableSaveButton(false)
                }
            }
            onDeleteNoteRequested: {
                controller.removeNoteById(noteId)
                root.selectedNoteId = -1
            }
        }

        NoteInput {
            id: noteInput
            visible: false
            Layout.fillWidth: true
            onTextChanged: toolbar.enableSaveButton(text.trim() !== "")
            onEnterPressed: toolbar.triggerSave()
        }

        NotesList {
            id: notesList
            mySpacing: root.mySpacing
            model: controller.filteredNotes
            onNoteSelected: root.selectedNoteId = noteId
        }

    }

}

