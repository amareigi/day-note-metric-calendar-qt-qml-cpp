//main.cpp
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>

#include "model/model.h"
#include "controller/controller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // Создаем модель на будущее
    Model model;
    Controller* controller = new Controller(&app, &model);

    app.setWindowIcon(QIcon(":/icons/logo_qttest.png"));

    engine.rootContext()->setContextProperty("controller", controller);

    engine.loadFromModule("qttest", "MainWindow");

    return app.exec();
}
