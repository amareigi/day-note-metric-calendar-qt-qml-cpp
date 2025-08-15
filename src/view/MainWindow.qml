// main_window.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "calendar"
import "note"
import "metric"

Window {
    id: root
    width: Screen.width / 2
    height: Screen.height / 2
    visible: true
    title: qsTr("Calendar with Notes and Chart")

    property real mySpacing: Math.min(root.width, root.height) * 0.005


    ColumnLayout {
        anchors.fill: parent
        anchors.margins: root.mySpacing
        spacing: root.mySpacing

        MyCalendar {
            Layout.fillWidth: true
            Layout.preferredHeight: Math.min(root.height * 0.4, 300)
            mySpacing: root.mySpacing
            displayedYear: controller.displayedYear
            selectedDate: controller.selectedDate
            onDayClicked: function(newSelectedDate) {
                controller.selectDate(newSelectedDate)
            }
        }

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: Math.min(root.height * 0.05, 100)
            font.pixelSize: Math.min(root.width * 0.08, root.height * 0.05)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            text: {
                if (controller.selectedDate instanceof Date) {
                    var selectedDay = controller.selectedDate;
                    var day = selectedDay.getDate();
                    var month = selectedDay.getMonth() + 1;
                    var year = selectedDay.getFullYear();
                    return (day < 10 ? "0" + day : day) + "." + (month < 10 ? "0" + month : month) + "." + year;
                } else {
                    return "Invalid Date";
                }
            }
        }


        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: root.mySpacing
            MyNote{
                     Layout.fillWidth: true
                     Layout.fillHeight: true
                     mySpacing: root.mySpacing
            }
            MyMetric{
                     Layout.fillWidth: true
                     Layout.fillHeight: true
                     mySpacing: root.mySpacing
            }
            MyChart {
                Layout.fillWidth: true
                Layout.fillHeight: true
                metrics: controller.filteredMetrics
            }
        }
    }
}
