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
    property int year: 0  // новый пропс


    signal dayClicked(int monthIndex, int dayIndex)

    // массив с названиями месяцев в именительном падеже
    property var monthNames: ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь",
                             "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]

    ColumnLayout {
        anchors.fill: parent
        spacing: root.mySpacing

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
                    monthIndex: root.monthIndex
                    year: root.year   // <-- вот тут используем переданный год

                    // Выделение: только для валидных дней, совпадающих с selectedDay и текущим месяцем
                    isSelected: {
                         return dayIndex > 0 &&
                                dayIndex === root.selectedDate.getDate() &&
                                monthIndex === root.selectedDate.getMonth() &&
                                year === root.selectedDate.getFullYear()
                     }
                    // Клик: только для валидных дней, передаём dayIndex (начинается с 1, поэтому -1 для 0-based)
                    onDayClicked: function(dayIndex) {
                            root.dayClicked(root.monthIndex, dayIndex);
                    }
                }
            }
        }
    }
}


