//MyDay.qml
import QtQuick

Rectangle {
    id: root

    property int dayIndex: -1
    property bool isSelected: false
    property real myFontSize: 0.0
    property int monthIndex: -1
    property int year: -1

    signal dayClicked(int dayIndex)

    function ratingToColor(rating) {
        if (rating === -1) {
            return "lightgray"; // Цвет для дней без оценок
        }
        var t = (rating - 1) / 9; // нормализация в диапазон 0..1
        var r = Math.round(255 * (1 - t));
        var g = Math.round(255 * t);
        return Qt.rgba(r / 255, g / 255, 0, 1);
    }

    // Функция обновления цвета дня
    function updateDayColor() {
        if (dayIndex <= 0) {
            color = "white"; // дни вне месяца
            return;
        }

        var dateStr = Qt.formatDate(new Date(year, monthIndex, dayIndex), "yyyy-MM-dd");
        var avg = controller.averageRatingForDate(dateStr);
        color = ratingToColor(avg);
    }

    // Изначально рассчитываем цвет
    color: {
        updateDayColor(); // Вызываем функцию для установки цвета
        return color; // Возвращаем текущий цвет
    }

    onYearChanged: {
        updateDayColor();
    }
    Component.onCompleted: {
        updateDayColor();
    }

    border.color: isSelected ? "red" : "black"
    border.width: 1

    Text {
        id: txt
        text: root.dayIndex > 0 ? dayIndex.toString() : ""
        anchors.centerIn: parent
        font.pixelSize: Math.min(parent.width * 0.5, parent.height * 0.5)
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (root.dayIndex > 0) {
                root.dayClicked(root.dayIndex);
            }
        }
    }

    Connections {
        target: controller

        // Явное определение обработчика
        function onMetricsUpdated() {
            root.updateDayColor(); // Обновляем цвет при изменении метрик
        }
        function onDisplayedYearChanged() {
                root.updateDayColor();
            }
    }
}

