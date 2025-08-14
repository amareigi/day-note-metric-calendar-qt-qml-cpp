// MetricCard.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property real mySpacing: 8.0
    property string date
    property string name
    property int rating
    property int idMetric: -1
    property bool editing: false

    property real fontSmall: Math.max(10, root.width * 0.05)
    property real fontNormal: Math.max(12, root.width * 0.06)
    property real fontIcon: Math.max(16, root.width * 0.07)

    signal cardClicked(int metricId)

    color: "#F7F7FF"
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
                text: "\u2699"
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
                    id: nameEditor
                    text: root.name
                    font.pixelSize: root.fontNormal
                    wrapMode: TextEdit.Wrap
                    Layout.fillWidth: true
                    readOnly: !root.editing
                    selectByMouse: root.editing

                    Keys.onReturnPressed: {
                        if (!(event.modifiers & Qt.ShiftModifier)) {
                            event.accepted = true
                            finishEditing()
                        }
                    }
                    Keys.onEnterPressed: {
                        if (!(event.modifiers & Qt.ShiftModifier)) {
                            event.accepted = true
                            finishEditing()
                        }
                    }
                    Keys.onEscapePressed: {
                        event.accepted = true
                        root.editing = false
                        text = root.name
                    }

                    onEditingFinished: finishEditing()

                    function finishEditing() {
                        var newName = text.trim()
                        var newRating = ratingEditor.value
                        var changed = false

                        if (newName !== root.name) {
                            root.name = newName
                            controller.updateMetricName(root.idMetric, root.name)
                            changed = true
                        }

                        if (newRating !== root.rating) {
                            root.rating = newRating
                            controller.updateMetricRating(root.idMetric, root.rating)
                            changed = true
                        }

                        root.editing = false
                    }

                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 4

                    Text {
                        text: "Оценка: " + rating
                        font.pixelSize: root.fontSmall
                        color: "#555"
                        visible: !root.editing
                    }

                    SpinBox {
                        id: ratingEditor
                        Layout.fillWidth: true
                        from: 1
                        to: 10
                        stepSize: 1
                        value: root.rating
                        visible: root.editing
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: !root.editing   // <--- блокируем клики, если редактируем
        onClicked: root.cardClicked(root.idMetric)
        onDoubleClicked: {
            editing = true
            nameEditor.forceActiveFocus()
            ratingEditor.value = root.rating
        }
    }

    implicitHeight: Math.max(64, card.implicitHeight + mySpacing * 2)
}


