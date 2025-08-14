// MyChart.qml
import QtQuick
import QtQuick.Controls

Item {
    id: root
    property var metrics: [] // [{ name, rating }, ...]

    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            const ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            const paddingLeft = 40    // место для оси Y
            const paddingBottom = 40  // место для подписей
            const paddingTop = 10
            const chartHeight = height - paddingTop - paddingBottom
            const chartWidth = width - paddingLeft - 10

            // 1. Рисуем сетку и шкалу Y
            ctx.strokeStyle = "#ccc"
            ctx.fillStyle = "#000"
            ctx.font = "12px sans-serif"
            ctx.textAlign = "right"
            ctx.textBaseline = "middle"

            for (let gridIndex = 0; gridIndex <= 10; gridIndex++) {
                let y = paddingTop + chartHeight - (gridIndex / 10) * chartHeight
                ctx.beginPath()
                ctx.moveTo(paddingLeft, y)
                ctx.lineTo(width, y)
                ctx.stroke()

                ctx.fillText(gridIndex.toString(), paddingLeft - 5, y)
            }

            // 2. Рисуем столбцы
            if (!metrics || metrics.length === 0)
                return

            const barWidth = chartWidth / metrics.length * 0.6
            const barSpacing = chartWidth / metrics.length

            ctx.textAlign = "center"
            ctx.textBaseline = "top"
            ctx.fillStyle = "#42A5F5"

            for (let barIndex = 0; barIndex < metrics.length; barIndex++) {
                let m = metrics[barIndex]
                if (!m || typeof m !== "object")
                    continue

                let name = m["name"]
                let rating = m["rating"]

                if (typeof rating !== "number")
                    continue

                // высота столбца
                let h = (rating / 10) * chartHeight
                let x = paddingLeft + barIndex * barSpacing + (barSpacing - barWidth) / 2
                let y = paddingTop + chartHeight - h

                // столбик
                ctx.fillRect(x, y, barWidth, h)

                // подпись
                ctx.fillStyle = "#000"
                ctx.font = "10px sans-serif"

                // Проверяем ширину текста
                let textWidth = ctx.measureText(name).width
                let maxTextWidth = barWidth * 0.9 // Оставляем небольшой запас
                let displayName = name
                if (textWidth > maxTextWidth) {
                    // Оцениваем, сколько символов поместится
                    let chars = Math.floor(name.length * (maxTextWidth / textWidth))
                    chars = Math.max(chars - 3, 1) // Учитываем место для "..."
                    displayName = name.substring(0, chars) + "..."
                }

                ctx.fillText(displayName, x + barWidth / 2, height - paddingBottom + 5)

                ctx.fillStyle = "#42A5F5" // вернуть цвет для следующего столбца
            }
        }
    }

    onMetricsChanged: {
        canvas.requestPaint()
    }
    Component.onCompleted: canvas.requestPaint()
}

