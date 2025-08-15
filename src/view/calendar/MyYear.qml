// MyYear.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    property real mySpacing: 0.0

    property int displayedYear: 1
    property date selectedDate: Qt.invalid


    signal dayClicked(date newSelectedDate)

    ListView {
        id: monthView
        anchors.fill: parent
        orientation: ListView.Horizontal
        highlightRangeMode: ListView.ApplyRange
        clip: true
        cacheBuffer: 3
        model: 12
        snapMode: ListView.SnapToItem
        spacing: root.mySpacing * 2

        delegate: MyMonth {
            width: Math.min(root.width, 270)
            height: root.height
            monthIndex: index

            selectedDate: root.selectedDate
            year: root.displayedYear

            firstDayOfWeek: {
                var firstdayofweek = new Date(root.displayedYear, index, 1).getDay();
                return firstdayofweek === 0 ? 6 : firstdayofweek - 1;
            }
            daysInMonth:new Date(root.displayedYear, index + 1, 0).getDate()

            mySpacing: root.mySpacing
            onDayClicked: function(monthIndex, dayIndex) {
                var newSelectedDate = new Date(root.displayedYear, monthIndex, dayIndex);
                root.dayClicked(newSelectedDate);
            }
        }

        boundsBehavior: Flickable.StopAtBounds
        flickDeceleration: 1000
    }
}

