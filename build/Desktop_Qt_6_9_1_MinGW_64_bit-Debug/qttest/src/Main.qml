import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.example.calendar 1.0 // Импорт модели календаря
import com.example.notes 1.0   // Импорт модели заметок
import com.example.chart 1.0   // Импорт модели графика

// Главное окно приложения
Window {
    width: 800              // Ширина окна
    height: 600             // Высота окна
    visible: true           // Окно видно при запуске
    title: qsTr("Calendar with Notes and Chart") // Заголовок окна (с поддержкой перевода)

    // Модель календаря, предоставляется из C++ или контекста
    CalendarModel {
        id: calendarModel
    }

    // Модель заметок
    NotesModel {
        id: notesModel
    }

    // Модель графика
    ChartModel {
        id: chartModel
    }

    // Основной макет — вертикальный
    ColumnLayout {
        anchors.fill: parent // Заполняет всё окно
        spacing: 10          // Отступ между элементами

        // Заголовок: месяц и год
        Text {
            Layout.alignment: Qt.AlignHCenter // Центрирование по горизонтали
            text: Qt.formatDateTime(calendarModel.firstDayOfMonth, "MMMM yyyy") // Отображение месяца и года из модели
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

            // Пустые ячейки перед первым днём месяца
            Repeater {
                model: calendarModel.firstDayOfWeek // Количество пустых ячеек из модели
                Item {
                    Layout.preferredWidth: 40  // Фиксированная ширина ячейки
                    Layout.preferredHeight: 40 // Фиксированная высота ячейки
                }
            }

            // Ячейки дней месяца
            Repeater {
                model: calendarModel.daysInMonth // Количество дней в месяце из модели
                Rectangle {
                    Layout.preferredWidth: 40  // Ширина ячейки
                    Layout.preferredHeight: 40 // Высота ячейки
                    color: calendarModel.selectedDate.day === (index + 1) &&
                           (calendarModel.selectedDate.month - 1) === calendarModel.currentMonth &&
                           calendarModel.selectedDate.year === calendarModel.currentYear ? "#d3d3d3" : "white" // Подсветка выбранного дня
                    border.color: "black"      // Чёрная рамка

                    Text {
                        anchors.centerIn: parent // Центрирование текста в ячейке
                        text: index + 1         // Номер дня (начинается с 1)
                    }

                    MouseArea {
                        anchors.fill: parent // Область клика на всю ячейку
                        onClicked: {
                            // Заглушка: вызов метода контроллера для установки выбранной даты
                            calendarController.selectDate(calendarModel.currentYear, calendarModel.currentMonth, index + 1)
                        }
                    }
                }
            }
        }

        // Нижняя часть: заметки и график
        RowLayout {
            Layout.fillWidth: true  // Заполняет ширину
            Layout.fillHeight: true // Заполняет высоту
            spacing: 10             // Отступ между блоками

            // Блок заметок
            ColumnLayout {
                Layout.preferredWidth: parent.width / 2 // Половина ширины
                Layout.fillHeight: true                // Заполняет высоту
                spacing: 10                            // Отступ между элементами

                Text {
                    text: "Заметки для " + Qt.formatDate(calendarModel.selectedDate, "dd.MM.yyyy") // Заголовок с датой
                    font.pixelSize: 16   // Размер шрифта
                    font.bold: true      // Жирный шрифт
                }

                TextArea {
                    id: noteTextArea
                    Layout.fillWidth: true   // Заполняет ширину
                    Layout.fillHeight: true  // Заполняет высоту
                    placeholderText: "Введите заметку..." // Подсказка
                    wrapMode: TextArea.Wrap  // Перенос текста
                }

                Button {
                    text: "Сохранить заметку" // Текст кнопки
                    onClicked: {
                        // Заглушка: вызов метода контроллера для сохранения заметки
                        notesController.saveNote(calendarModel.selectedDate, noteTextArea.text)
                    }
                }
            }

            // Блок графика
            Canvas {
                id: chartCanvas
                Layout.preferredWidth: parent.width / 2 // Половина ширины
                Layout.fillHeight: true                // Заполняет высоту

                onPaint: {
                    var ctx = getContext("2d") // Получаем контекст 2D для рисования
                    ctx.clearRect(0, 0, width, height) // Очищаем область
                    ctx.strokeStyle = "black" // Цвет линий
                    ctx.lineWidth = 2         // Толщина линий

                    // Оси графика
                    ctx.beginPath()
                    ctx.moveTo(50, height - 30) // Начало оси X
                    ctx.lineTo(50, 30)          // Вертикальная ось Y
                    ctx.lineTo(width - 30, 30)  // Горизонтальная верхняя линия
                    ctx.stroke()

                    // Подписи осей
                    ctx.font = "12px Arial"
                    ctx.fillText("День", width / 2, height - 10) // Подпись оси X
                    ctx.save()
                    ctx.translate(20, height / 2)
                    ctx.rotate(-Math.PI / 2)
                    ctx.fillText("Значение", 0, 0) // Подпись оси Y
                    ctx.restore()

                    // Шкала Y (1-10)
                    for (var i = 1; i <= 10; i++) {
                        var y = height - 30 - (i * (height - 60) / 10)
                        ctx.fillText(i, 30, y + 5) // Метки на оси Y
                    }

                    // Заглушка: здесь будет рисоваться график
                    // Вызов метода контроллера для получения данных (в будущем)
                    // chartController.drawChart(ctx, chartModel)
                }
            }
        }
    }

    // Кнопки для листания месяцев
    RowLayout {
        anchors.top: parent.top   // Привязка к верхнему краю окна
        anchors.right: parent.right // Привязка к правому краю
        spacing: 10               // Отступ между кнопками

        Button {
            text: "<" // Кнопка назад
            onClicked: {
                // Заглушка: вызов метода контроллера для смены месяца назад
                calendarController.changeMonth(-1)
            }
        }
        Button {
            text: ">" // Кнопка вперёд
            onClicked: {
                // Заглушка: вызов метода контроллера для смены месяца вперёд
                calendarController.changeMonth(1)
            }
        }
    }
}
