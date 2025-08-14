// MetricToolbar
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: root
    property real mySpacing: 8.0
    signal newMetricRequested()
    signal saveMetricRequested()
    signal deleteMetricRequested(int metricId)
    property int selectedMetricId: -1

    Layout.fillWidth: true
    spacing: mySpacing * 2
    Layout.preferredHeight: parent ? parent.height * 0.08 : 50
    Layout.fillHeight: false

    Button {
        text: "Новая метрика"
        Layout.fillWidth: true
        Layout.fillHeight: true
        onClicked: root.newMetricRequested()
    }

    Button {
        id: saveButton
        text: "Сохранить"
        Layout.fillWidth: true
        Layout.fillHeight: true
        enabled: false
        onClicked: root.saveMetricRequested()
    }

    Button {
        text: "Удалить"
        Layout.fillWidth: true
        Layout.fillHeight: true
        enabled: root.selectedMetricId >= 0
        onClicked: root.deleteMetricRequested(root.selectedMetricId)
    }

    function enableSaveButton(enabled) { saveButton.enabled = enabled }
    function triggerSave() { saveButton.clicked() }
}



