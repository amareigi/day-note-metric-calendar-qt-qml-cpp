// NoteInput.qml
import QtQuick
import QtQuick.Controls

TextArea {
    id: root
    signal enterPressed()

    placeholderText: "Введите новую заметку..."
    wrapMode: TextEdit.Wrap


    background: Rectangle {
        color: "#f9f9f9"
        border.color: "#cccccc"
        border.width: 1
        radius: 6
    }

    Keys.onReturnPressed: {
        if (!(event.modifiers & Qt.ShiftModifier)) {
            event.accepted = true
            root.enterPressed()
        } else {
            event.accepted = false
        }
    }

    Keys.onEnterPressed: {
        if (!(event.modifiers & Qt.ShiftModifier)) {
            event.accepted = true
            root.enterPressed()
        } else {
            event.accepted = false
        }
    }
}
