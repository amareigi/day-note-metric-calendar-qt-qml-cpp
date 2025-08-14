// NoteCard.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property real mySpacing: 8.0
    property string date
    property string content
    property int idNote: -1
    property bool editing: false

    property real fontSmall: Math.max(10, root.width * 0.05)
    property real fontNormal: Math.max(12, root.width * 0.06)
    property real fontIcon: Math.max(16, root.width * 0.07)



    signal cardClicked(int noteId)


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
                font.pixelSize: root.fontIcon
                color: "#444"
                Layout.alignment: Qt.AlignTop
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 2

                Text {
                    text: root.date
                    font.pixelSize: root.fontSmall
                    color: "#777"
                    Layout.fillWidth: true
                }

                TextEdit {
                    id: contentEditor
                    text: root.content
                    font.pixelSize: root.fontNormal
                    wrapMode: TextEdit.Wrap
                    Layout.fillWidth: true
                    readOnly: !root.editing
                    selectByMouse: root.editing

                    // Enter (основной)
                    Keys.onReturnPressed: {
                        if (!(event.modifiers & Qt.ShiftModifier)) {
                            event.accepted = true
                            finishEditing()
                        } else {
                            event.accepted = false
                        }
                    }

                    // Enter (на доп. клавиатуре)
                    Keys.onEnterPressed: {
                        if (!(event.modifiers & Qt.ShiftModifier)) {
                            event.accepted = true
                            finishEditing()
                        } else {
                            event.accepted = false
                        }
                    }

                    // Esc — выход без сохранения
                    Keys.onEscapePressed: {
                        event.accepted = true
                        root.editing = false
                        text = root.content
                    }

                    onEditingFinished: {
                        finishEditing()
                    }

                    function finishEditing() {
                        if (text.trim() !== root.content) {
                            root.content = text.trim()
                            controller.updateNoteContent(root.idNote, root.content)
                        }
                        root.editing = false
                    }
                }
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: root.cardClicked(root.idNote)
        onDoubleClicked: {
            editing = true
            contentEditor.forceActiveFocus()
        }
    }

    implicitHeight: Math.max(64, card.implicitHeight + mySpacing * 2)
}

