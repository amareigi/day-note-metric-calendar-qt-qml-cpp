import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
//MyCalendar.qml
Item {
    id: root

    property real mySpacing: 0.0

    property int displayedYear: 1
    property date selectedDate: Qt.invalid


    signal dayClicked(date newSelectedDate)


    ColumnLayout {
        anchors.fill: parent
        spacing: root.mySpacing

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.1
            spacing: root.mySpacing

            Button {
                text: "<"
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.pixelSize: Math.min(root.width * 0.08, root.height * 0.05)
                onClicked: controller.prevYear() // тут поменять
            }
            Label {
                id: myLabel
                Layout.fillWidth: true
                Layout.fillHeight: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: root.displayedYear
                font.pixelSize: Math.min(root.width * 0.08, root.height * 0.05)
            }
            Button {
                text: ">"
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.pixelSize: Math.min(root.width * 0.08, root.height * 0.05)
                onClicked: controller.nextYear() // тут поменять
            }
        }

        MyYear {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.9
            displayedYear: root.displayedYear
            selectedDate: root.selectedDate
            mySpacing: root.mySpacing
            onDayClicked: function(newSelectedDate) {
                    root.dayClicked(newSelectedDate);
            }
        }
    }
}

