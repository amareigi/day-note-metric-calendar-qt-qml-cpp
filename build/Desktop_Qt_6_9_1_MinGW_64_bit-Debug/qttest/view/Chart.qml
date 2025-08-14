// Chart.qml
import QtQuick
import QtQuick.Controls
import QtCharts

Item {
   anchors.fill: parent
   // roperty var metrics

   ChartView {
       anchors.fill: parent
       legend.visible: false
       antialiasing: true

       BarSeries {
           axisX: BarCategoryAxis { categories: ["Test1", "Test2"] }
           axisY: ValueAxis { min: 0; max: 10 }
           BarSet { values: [5, 8] }
       }
   }
}
