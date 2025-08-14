import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
        // Заголовок: месяц и год
        Text {
            Layout.alignment: Qt.AlignHCenter // Центрирование по горизонтали
           // text: Qt.formatDateTime(calendarModel.firstDayOfMonth, "MMMM yyyy") // Отображение месяца и года из модели
            text: Август // Отображение месяца и года из модели
            font.pixelSize: 20   // Размер шрифта
            font.bold: true      // Жирный шрифт
        }

        // Календарь: сетка 7x6 (дни недели + дни месяца)
        GridLayout {
            Layout.alignment: Qt.AlignHCenter // Центрирование в макете
            columns: 7           // 7 столбцов (дни недели)
            rows: 7              // 7 строк (1 для заголовков + 6 для дней)
            columnSpacing: 5     // Отступ между столбцами
            rowSpacing: 5        // Отступ между строками

            // Заголовки дней недели
            Repeater {
                model: ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"] // Статическая модель для дней недели
                Text {
                    Layout.alignment: Qt.AlignHCenter // Центрирование текста
                    text: modelData      // Отображение дня недели (Пн, Вт и т.д.)
                    font.bold: true      // Жирный шрифт
                    font.pixelSize: 14   // Размер шрифта
                }
            }
        }
}
