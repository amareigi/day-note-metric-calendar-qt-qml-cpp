// // CalendarView.qml
// import QtQuick
// import QtQuick.Controls

// ColumnLayout {
//     // Controller
//     property var calendarController: null

//     // Элементы управления
//     RowLayout {
//         Button {
//             text: "<"
//             onClicked: calendarController.goToPreviousMonth()
//         }
//         Label {
//             text: calendarController.currentMonthAndYear // Получаем из контроллера
//         }
//         Button {
//             text: ">"
//             onClicked: calendarController.goToNextMonth()
//         }
//     }

//     // Сетка дней
//     GridView {
//         id: daysGrid
//         Layout.fillWidth: true
//         Layout.fillHeight: true

//         model: calendarController.calendarModel // Привязываем модель из контроллера

//         cellWidth: width / 7
//         cellHeight: height / 6

//         delegate: Rectangle {
//             width: daysGrid.cellWidth
//             height: daysGrid.cellHeight
//             border.color: "gray"

//             // Отображение дня
//             Text {
//                 text: day // Используем роль из C++ модели (DayRole)
//                 anchors.centerIn: parent
//                 color: isCurrentMonth ? "black" : "gray" // IsCurrentMonthRole
//                 font.bold: hasEvent // HasEventRole
//             }
//         }
//     }
// }
