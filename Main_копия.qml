import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    width: 800
    height: 600
    visible: true
    title: qsTr("Calendar with Notes and Chart")

    // Модель для хранения заметок
    ListModel {
        id: notesModel
    }

    // Текущая дата
    property date currentDate: new Date()
    property int currentMonth: currentDate.getMonth()
    property int currentYear: currentDate.getFullYear()
    property date selectedDate: currentDate

    // Вычисление первого дня месяца и количества дней
    property date firstDayOfMonth: new Date(currentYear, currentMonth, 1)
    property int daysInMonth: new Date(currentYear, currentMonth + 1, 0).getDate()
    property int firstDayOfWeek: firstDayOfMonth.getDay() === 0 ? 6 : firstDayOfMonth.getDay() - 1

    // Генерация случайных данных для графика
    function generateChartData() {
        chartModel.clear()
        for (var i = 0; i < daysInMonth; i++) {
            chartModel.append({ day: i + 1, value: Math.floor(Math.random() * 10) + 1 })
        }
    }

    ListModel {
        id: chartModel
    }

    Component.onCompleted: generateChartData()

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        // Название месяца и года
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: Qt.formatDateTime(new Date(currentYear, currentMonth, 1), "MMMM yyyy")
            font.pixelSize: 20
            font.bold: true
        }

        // Календарь
        GridLayout {
            Layout.alignment: Qt.AlignHCenter
            columns: 7
            rows: 7
            columnSpacing: 5
            rowSpacing: 5

            // Дни недели
            Repeater {
                model: ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: modelData
                    font.bold: true
                    font.pixelSize: 14
                }
            }

            // Пустые ячейки до первого дня
            Repeater {
                model: firstDayOfWeek
                Item {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                }
            }

            // Ячейки дней
            Repeater {
                model: daysInMonth
                Rectangle {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    color: selectedDate.getDate() === (index + 1) &&
                           selectedDate.getMonth() === currentMonth &&
                           selectedDate.getFullYear() === currentYear ? "#d3d3d3" : "white"
                    border.color: "black"

                    Text {
                        anchors.centerIn: parent
                        text: index + 1
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            selectedDate = new Date(currentYear, currentMonth, index + 1)
                            // Фильтровать заметки для выбранного дня
                            var notes = ""
                            for (var i = 0; i < notesModel.count; i++) {
                                if (notesModel.get(i).date === Qt.formatDate(selectedDate, "yyyy-MM-dd")) {
                                    notes = notesModel.get(i).note
                                    break
                                }
                            }
                            noteTextArea.text = notes
                        }
                    }
                }
            }
        }

        // Нижняя часть: заметки и график
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            // Заметки
            ColumnLayout {
                Layout.preferredWidth: parent.width / 2
                Layout.fillHeight: true
                spacing: 10

                Text {
                    text: "Заметки для " + Qt.formatDate(selectedDate, "dd.MM.yyyy")
                    font.pixelSize: 16
                    font.bold: true
                }

                TextArea {
                    id: noteTextArea
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    placeholderText: "Введите заметку..."
                    wrapMode: TextArea.Wrap
                }

                Button {
                    text: "Сохранить заметку"
                    onClicked: {
                        var dateStr = Qt.formatDate(selectedDate, "yyyy-MM-dd")
                        for (var i = 0; i < notesModel.count; i++) {
                            if (notesModel.get(i).date === dateStr) {
                                notesModel.setProperty(i, "note", noteTextArea.text)
                                return
                            }
                        }
                        notesModel.append({ date: dateStr, note: noteTextArea.text })
                    }
                }
            }

            // График
            Canvas {
                id: chartCanvas
                Layout.preferredWidth: parent.width / 2
                Layout.fillHeight: true

                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    ctx.strokeStyle = "black"
                    ctx.lineWidth = 2

                    // Оси
                    ctx.beginPath()
                    ctx.moveTo(50, height - 30)
                    ctx.lineTo(50, 30)
                    ctx.lineTo(width - 30, 30)
                    ctx.stroke()

                    // Подписи осей
                    ctx.font = "12px Arial"
                    ctx.fillText("День", width / 2, height - 10)
                    ctx.save()
                    ctx.translate(20, height / 2)
                    ctx.rotate(-Math.PI / 2)
                    ctx.fillText("Значение", 0, 0)
                    ctx.restore()

                    // Шкала Y (1-10)
                    for (var i = 1; i <= 10; i++) {
                        var y = height - 30 - (i * (height - 60) / 10)
                        ctx.fillText(i, 30, y + 5)
                    }

                    // Данные графика
                    ctx.beginPath()
                    ctx.strokeStyle = "blue"
                    var stepX = (width - 80) / (daysInMonth - 1)
                    for (var j = 0; j < chartModel.count; j++) {
                        var x = 50 + j * stepX
                        var y = height - 30 - (chartModel.get(j).value * (height - 60) / 10)
                        if (j === 0) {
                            ctx.moveTo(x, y)
                        } else {
                            ctx.lineTo(x, y)
                        }
                    }
                    ctx.stroke()
                }
            }
        }
    }

    // Кнопки для переключения месяцев
    RowLayout {
        anchors.top: parent.top
        anchors.right: parent.right
        spacing: 10

        Button {
            text: "<"
            onClicked: {
                currentMonth--
                if (currentMonth < 0) {
                    currentMonth = 11
                    currentYear--
                }
                firstDayOfMonth = new Date(currentYear, currentMonth, 1)
                daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate()
                firstDayOfWeek = firstDayOfMonth.getDay() === 0 ? 6 : firstDayOfMonth.getDay() - 1
                generateChartData()
                chartCanvas.requestPaint()
            }
        }
        Button {
            text: ">"
            onClicked: {
                currentMonth++
                if (currentMonth > 11) {
                    currentMonth = 0
                    currentYear++
                }
                firstDayOfMonth = new Date(currentYear, currentMonth, 1)
                daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate()
                firstDayOfWeek = firstDayOfMonth.getDay() === 0 ? 6 : firstDayOfMonth.getDay() - 1
                generateChartData()
                chartCanvas.requestPaint()
            }
        }
    }
}
