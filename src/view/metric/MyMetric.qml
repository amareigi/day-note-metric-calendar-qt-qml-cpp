// MyMetric.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    property real mySpacing: 8.0
    property int selectedMetricId: -1

    ColumnLayout {
        anchors.fill: parent
        spacing: mySpacing

        MetricToolbar {
            id: toolbar
            mySpacing: root.mySpacing
            selectedMetricId: root.selectedMetricId

            onNewMetricRequested: {
                metricNameInput.visible = true
                metricRatingContainer.visible = true
                metricNameInput.editText = ""
                metricNameInput.forceActiveFocus()
                metricRatingInput.value = 5
                toolbar.enableSaveButton(true)
            }
            onSaveMetricRequested: {
                if (metricNameInput.editText.trim() !== "" && metricRatingInput.value >= 1) {
                    controller.addMetric(metricNameInput.editText, metricRatingInput.value)
                    metricNameInput.visible = false
                    metricRatingContainer.visible = false
                    toolbar.enableSaveButton(false)
                }
            }
            onDeleteMetricRequested: function(metricId) {
                controller.removeMetricById(metricId)
                root.selectedMetricId = -1
            }
        }

        ComboBox {
            id: metricNameInput
            visible: false
            editable: true
            Layout.fillWidth: true
            model: controller.allMetricNames
            onEditTextChanged: toolbar.enableSaveButton(editText.trim() !== "")
            Keys.onReturnPressed: toolbar.triggerSave()
            Keys.onEnterPressed: toolbar.triggerSave()
        }

        ColumnLayout {
            id: metricRatingContainer
            visible: false
            spacing: 4
            Layout.fillWidth: true

            Text {
                text: "Оценка: " + metricRatingInput.value
                font.pixelSize: 14
                color: "#333"
            }
            Slider {
                id: metricRatingInput
                from: 1
                to: 10
                value: 5
                stepSize: 1
                Layout.fillWidth: true
            }
        }

        MetricList {
            id: metricsList
            mySpacing: root.mySpacing
            model: controller.filteredMetrics
            onMetricSelected: function(metricId) {
                root.selectedMetricId = metricId
            }
        }
    }
}


