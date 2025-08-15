cmake_minimum_required(VERSION 3.16)

project(qttest VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.8 REQUIRED COMPONENTS Quick Core Sql Charts)

qt_standard_project_setup()

# Исполняемый файл
qt_add_executable(appqttest
    src/main.cpp
    src/model/model.h src/model/model.cpp
    src/controller/controller.h src/controller/controller.cpp
    src/controller/databasemanager.h src/controller/databasemanager.cpp
)

# Ресурсы (QML + иконки)
qt_add_qml_module(appqttest
    URI qttest
    VERSION 1.0
    QML_FILES
        src/view/MainWindow.qml
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
    RESOURCES
        icons/logo_qttest.png
)

# Свойства для macOS/Windows
set_target_properties(appqttest PROPERTIES
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# Линковка
target_link_libraries(appqttest
    PRIVATE
        Qt6::Core
        Qt6::Quick
        Qt6::Sql
        Qt6::Charts
)

# Установка
include(GNUInstallDirs)
install(TARGETS appqttest
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
