cmake_minimum_required(VERSION 3.16)

project(qttest VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Core Sql Charts)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appqttest
    src/main.cpp
)

qt_add_resources(appqttest "resources.qrc"
    PREFIX "/"
    FILES
        # Путь к QML-файлу относительно папки проекта
        src/view/main_window.qml
        src/view/calendar/MyCalendar.qml
        src/view/calendar/MyYear.qml
        src/view/calendar/MyMonth.qml
        src/view/calendar/MyDay.qml
        src/view/note/MyNote.qml
        src/view/note/NoteToolbar.qml
        src/view/note/NoteInput.qml
        src/view/note/NoteCard.qml
        src/view/note/NotesList.qml
        src/view/MyChart.qml
        src/view/metric/MyMetric.qml
        src/view/metric/MetricCard.qml
        src/view/metric/MetricInput.qml
        src/view/metric/MetricList.qml
        src/view/metric/MetricToolbar.qml
)

qt_add_qml_module(appqttest
    URI qttest
    VERSION 1.0
    QML_FILES
    src/view/main_window.qml
    RESOURCES
    src/view/calendar/MyCalendar.qml # Добавляем Calendar.qml в ресурсы
    SOURCES
    SOURCES src/model/model.h src/model/model.cpp
        SOURCES src/model/day.h src/model/day.cpp
        SOURCES src/model/note.h src/model/note.cpp
        SOURCES src/model/metrics.h src/model/metrics.cpp
        SOURCES src/controller/controller.h src/controller/controller.cpp
        QML_FILES src/view/note/MyNote.qml
        QML_FILES src/view/MyChart.qml
        QML_FILES src/view/calendar/MyYear.qml
        QML_FILES src/view/calendar/MyMonth.qml
        QML_FILES src/view/calendar/MyDay.qml
        QML_FILES
        QML_FILES src/view/note/NoteToolbar.qml
        QML_FILES src/view/note/NoteInput.qml
        QML_FILES src/view/note/NoteCard.qml
        QML_FILES src/view/note/NotesList.qml
        QML_FILES src/view/metric/MyMetric.qml
        QML_FILES src/view/metric/MetricCard.qml
        QML_FILES src/view/metric/MetricInput.qml
        QML_FILES src/view/metric/MetricList.qml
        QML_FILES src/view/metric/MetricToolbar.qml
        SOURCES src/controller/databasemanager.h src/controller/databasemanager.cpp
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
