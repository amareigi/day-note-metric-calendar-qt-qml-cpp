// ButtonPanel.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    property real spacing: 8.0
    signal newNoteClicked()
    signal saveNoteClicked(string noteText)
    signal deleteNoteClicked()

    implicitHeight: parent.height * 0.08

    RowLayout {
        anchors.fill: parent
        spacing: root.spacing * 2

        Button {
            id: newButton
            text: "Новая заметка"
            Layout.fillWidth: true
            Layout.fillHeight: true
            onClicked: root.newNoteClicked()
        }

        Button {
            id: saveButton
            text: "Сохранить"
            Layout.fillWidth: true
            Layout.fillHeight: true
            enabled: false
            onClicked: root.saveNoteClicked("") // Текст будет передан через MyNote
        }

        Button {
            id: deleteButton
            text: "Удалить"
            Layout.fillWidth: true
            Layout.fillHeight: true
            onClicked: root.deleteNoteClicked()
        }
    }

    function setSaveButtonEnabled(enabled) {
        saveButton.enabled = enabled
    }
}
