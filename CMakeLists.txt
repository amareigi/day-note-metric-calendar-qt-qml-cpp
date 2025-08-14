cmake_minimum_required(VERSION 3.16)

project(qttest VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Core Sql Charts)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appqttest
    main.cpp
)

qt_add_resources(appqttest "resources.qrc"
    PREFIX "/"
    FILES
        # Путь к QML-файлу относительно папки проекта
        view/main_window.qml
        view/calendar/MyCalendar.qml
        view/calendar/MyYear.qml
        view/calendar/MyMonth.qml
        view/calendar/MyDay.qml
        view/note/MyNote.qml
        view/note/NoteToolbar.qml
        view/note/NoteInput.qml
        view/note/NoteCard.qml
        view/note/NotesList.qml
        view/MyChart.qml
        view/metric/MyMetric.qml
        view/metric/MetricCard.qml
        view/metric/MetricInput.qml
        view/metric/MetricList.qml
        view/metric/MetricToolbar.qml
)

qt_add_qml_module(appqttest
    URI qttest
    VERSION 1.0
    QML_FILES
    view/main_window.qml
    RESOURCES
    view/calendar/MyCalendar.qml # Добавляем Calendar.qml в ресурсы
    SOURCES
    SOURCES model/model.h model/model.cpp
        SOURCES model/day.h model/day.cpp
        SOURCES model/note.h model/note.cpp
        SOURCES model/metrics.h model/metrics.cpp
        SOURCES controller/controller.h controller/controller.cpp
        QML_FILES view/note/MyNote.qml
        QML_FILES view/MyChart.qml
        QML_FILES view/calendar/MyYear.qml
        QML_FILES view/calendar/MyMonth.qml
        QML_FILES view/calendar/MyDay.qml
        QML_FILES
        QML_FILES view/note/NoteToolbar.qml
        QML_FILES view/note/NoteInput.qml
        QML_FILES view/note/NoteCard.qml
        QML_FILES view/note/NotesList.qml
        QML_FILES view/metric/MyMetric.qml
        QML_FILES view/metric/MetricCard.qml
        QML_FILES view/metric/MetricInput.qml
        QML_FILES view/metric/MetricList.qml
        QML_FILES view/metric/MetricToolbar.qml
        SOURCES controller/databasemanager.h controller/databasemanager.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appqttest PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appqttest
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appqttest
    PRIVATE
        Qt6::Core
        Qt6::Quick
        Qt6::Sql
        Qt6::Charts
)

include(GNUInstallDirs)
install(TARGETS appqttest
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
