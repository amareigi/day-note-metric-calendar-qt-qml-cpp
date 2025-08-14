// MyMonth.qml
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property real mySpacing: 100.0


    property date selectedDate: Qt.invalid
    property int monthIndex: 0
    property int firstDayOfWeek: 0
    property int daysInMonth: 0


    signal dayClicked(int monthIndex, int dayIndex)

    // массив с названиями месяцев в именительном падеже
    property var monthNames: ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь",
                             "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]

    ColumnLayout {
        anchors.fill: parent
        spacing: root.mySpacing

        //Layout.leftMargin: mySpacing
        //Layout.rightMargin: mySpacing

        Text {
            id: monthTitle
            text: root.monthNames[root.monthIndex]
            Layout.fillWidth: true
            height: parent.height * 0.125
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: Math.min(root.width * 0.08, root.height * 0.05)
        }

        GridLayout { // вынес отдельно т.к. шрифт не моноширинный и ломал сетку Пн шире остальных
            id: daysOfWeekTitle
            Layout.fillWidth: true
            height: parent.height * 0.125
            columns: 7
            rows: 1
            columnSpacing: root.mySpacing
            rowSpacing: root.mySpacing
            Repeater {
                model: ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
                Text {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: modelData
                    font.bold: true
                    font.pixelSize: Math.min(root.width * 0.08, root.height * 0.05)
                }
            }
        }

        GridLayout {
            Layout.fillWidth: true
            height: parent.height * 0.75
            columns: 7
            rows: 6
            columnSpacing: root.mySpacing
            rowSpacing: root.mySpacing

            Repeater {
                model: 42  // Фиксированная сетка 7x6 для стабильной высоты месяца

                MyDay {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    dayIndex: {
                        // Номер дня: index - firstDayOfWeek + 1
                        var calculatedDayNumber = index - root.firstDayOfWeek + 1;
                        // Если ячейка до первого дня или после последнего, то dayIndex = -1
                        return (index >= root.firstDayOfWeek && calculatedDayNumber <= root.daysInMonth) ? calculatedDayNumber : -1;
                    }
                    // Выделение: только для валидных дней, совпадающих с selectedDay и текущим месяцем
                    isSelected: {
                        // console.log("Month111:dayIndex ", dayIndex);
                        // console.log("Month111:root.selectedDate.getDate() ", root.selectedDate.getDate());
                        // console.log("Month111:root.monthIndex ", root.monthIndex);
                        // console.log("Month111:root.selectedDate.getMonth() ", root.selectedDate.getMonth());
                        return dayIndex > 0 && dayIndex === root.selectedDate.getDate() && root.monthIndex === root.selectedDate.getMonth()
                    }
                    // Клик: только для валидных дней, передаём dayIndex (начинается с 1, поэтому -1 для 0-based)
                    onDayClicked: function(dayIndex) {
                            root.dayClicked(root.monthIndex, dayIndex);
                            console.log("Month:dayCliced, index:", dayIndex);
                            console.log("Month:monthIndex:", root.monthIndex);
                    }
                }
            }
        }
    }
}


