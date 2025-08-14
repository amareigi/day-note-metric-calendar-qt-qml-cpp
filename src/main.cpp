//main.cpp
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "model/model.h"
#include "controller/controller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // Создаем модель и контроллер, указывая app как родителя
    Model model;
    Controller* controller = new Controller(&app, &model);

    // Регистрируем контроллер в QML
    engine.rootContext()->setContextProperty("controller", controller);

    const QUrl url(QStringLiteral("qrc:src/view/main_window.qml"));
    engine.load(url);

    return app.exec();
}
