/****************************************************************************
** Meta object code from reading C++ file 'controller.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../src/controller/controller.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'controller.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 69
#error "This file was generated using the moc from 6.9.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {
struct qt_meta_tag_ZN10ControllerE_t {};
} // unnamed namespace

template <> constexpr inline auto Controller::qt_create_metaobjectdata<qt_meta_tag_ZN10ControllerE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "Controller",
        "displayedYearChanged",
        "",
        "systemDateChanged",
        "selectedDateChanged",
        "filteredNotesChanged",
        "filteredMetricsChanged",
        "allMetricNamesChanged",
        "metricsUpdated",
        "nextYear",
        "prevYear",
        "selectDate",
        "newSelectedDate",
        "averageRatingForDate",
        "isoDate",
        "addNote",
        "content",
        "removeLastNote",
        "removeNoteById",
        "id",
        "updateNoteContent",
        "newContent",
        "addMetric",
        "name",
        "rating",
        "removeLastMetric",
        "removeMetricById",
        "updateMetricName",
        "newName",
        "updateMetricRating",
        "newRating",
        "displayedYear",
        "systemDate",
        "selectedDate",
        "filteredNotes",
        "QVariantList",
        "filteredMetrics",
        "allMetricNames"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'displayedYearChanged'
        QtMocHelpers::SignalData<void()>(1, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'systemDateChanged'
        QtMocHelpers::SignalData<void()>(3, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'selectedDateChanged'
        QtMocHelpers::SignalData<void()>(4, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'filteredNotesChanged'
        QtMocHelpers::SignalData<void()>(5, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'filteredMetricsChanged'
        QtMocHelpers::SignalData<void()>(6, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'allMetricNamesChanged'
        QtMocHelpers::SignalData<void()>(7, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'metricsUpdated'
        QtMocHelpers::SignalData<void()>(8, 2, QMC::AccessPublic, QMetaType::Void),
        // Slot 'nextYear'
        QtMocHelpers::SlotData<void()>(9, 2, QMC::AccessPublic, QMetaType::Void),
        // Slot 'prevYear'
        QtMocHelpers::SlotData<void()>(10, 2, QMC::AccessPublic, QMetaType::Void),
        // Slot 'selectDate'
        QtMocHelpers::SlotData<void(QDate)>(11, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QDate, 12 },
        }}),
        // Slot 'averageRatingForDate'
        QtMocHelpers::SlotData<double(const QString &)>(13, 2, QMC::AccessPublic, QMetaType::Double, {{
            { QMetaType::QString, 14 },
        }}),
        // Slot 'addNote'
        QtMocHelpers::SlotData<void(const QString &)>(15, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 16 },
        }}),
        // Slot 'removeLastNote'
        QtMocHelpers::SlotData<void()>(17, 2, QMC::AccessPublic, QMetaType::Void),
        // Slot 'removeNoteById'
        QtMocHelpers::SlotData<void(int)>(18, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 19 },
        }}),
        // Slot 'updateNoteContent'
        QtMocHelpers::SlotData<void(int, const QString &)>(20, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 19 }, { QMetaType::QString, 21 },
        }}),
        // Slot 'addMetric'
        QtMocHelpers::SlotData<void(const QString &, int)>(22, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 23 }, { QMetaType::Int, 24 },
        }}),
        // Slot 'removeLastMetric'
        QtMocHelpers::SlotData<void()>(25, 2, QMC::AccessPublic, QMetaType::Void),
        // Slot 'removeMetricById'
        QtMocHelpers::SlotData<void(int)>(26, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 19 },
        }}),
        // Slot 'updateMetricName'
        QtMocHelpers::SlotData<void(int, const QString &)>(27, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 19 }, { QMetaType::QString, 28 },
        }}),
        // Slot 'updateMetricRating'
        QtMocHelpers::SlotData<void(int, int)>(29, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 19 }, { QMetaType::Int, 30 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'displayedYear'
        QtMocHelpers::PropertyData<int>(31, QMetaType::Int, QMC::DefaultPropertyFlags, 0),
        // property 'systemDate'
        QtMocHelpers::PropertyData<QDate>(32, QMetaType::QDate, QMC::DefaultPropertyFlags, 1),
        // property 'selectedDate'
        QtMocHelpers::PropertyData<QDate>(33, QMetaType::QDate, QMC::DefaultPropertyFlags, 2),
        // property 'filteredNotes'
        QtMocHelpers::PropertyData<QVariantList>(34, 0x80000000 | 35, QMC::DefaultPropertyFlags | QMC::EnumOrFlag, 3),
        // property 'filteredMetrics'
        QtMocHelpers::PropertyData<QVariantList>(36, 0x80000000 | 35, QMC::DefaultPropertyFlags | QMC::EnumOrFlag, 4),
        // property 'allMetricNames'
        QtMocHelpers::PropertyData<QStringList>(37, QMetaType::QStringList, QMC::DefaultPropertyFlags, 5),
    };
    QtMocHelpers::UintData qt_enums {
    };
    return QtMocHelpers::metaObjectData<Controller, qt_meta_tag_ZN10ControllerE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject Controller::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN10ControllerE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN10ControllerE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN10ControllerE_t>.metaTypes,
    nullptr
} };

void Controller::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<Controller *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->displayedYearChanged(); break;
        case 1: _t->systemDateChanged(); break;
        case 2: _t->selectedDateChanged(); break;
        case 3: _t->filteredNotesChanged(); break;
        case 4: _t->filteredMetricsChanged(); break;
        case 5: _t->allMetricNamesChanged(); break;
        case 6: _t->metricsUpdated(); break;
        case 7: _t->nextYear(); break;
        case 8: _t->prevYear(); break;
        case 9: _t->selectDate((*reinterpret_cast< std::add_pointer_t<QDate>>(_a[1]))); break;
        case 10: { double _r = _t->averageRatingForDate((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])));
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 11: _t->addNote((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 12: _t->removeLastNote(); break;
        case 13: _t->removeNoteById((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 14: _t->updateNoteContent((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 15: _t->addMetric((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[2]))); break;
        case 16: _t->removeLastMetric(); break;
        case 17: _t->removeMetricById((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 18: _t->updateMetricName((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 19: _t->updateMetricRating((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[2]))); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (Controller::*)()>(_a, &Controller::displayedYearChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (Controller::*)()>(_a, &Controller::systemDateChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (Controller::*)()>(_a, &Controller::selectedDateChanged, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (Controller::*)()>(_a, &Controller::filteredNotesChanged, 3))
            return;
        if (QtMocHelpers::indexOfMethod<void (Controller::*)()>(_a, &Controller::filteredMetricsChanged, 4))
            return;
        if (QtMocHelpers::indexOfMethod<void (Controller::*)()>(_a, &Controller::allMetricNamesChanged, 5))
            return;
        if (QtMocHelpers::indexOfMethod<void (Controller::*)()>(_a, &Controller::metricsUpdated, 6))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<int*>(_v) = _t->displayedYear(); break;
        case 1: *reinterpret_cast<QDate*>(_v) = _t->systemDate(); break;
        case 2: *reinterpret_cast<QDate*>(_v) = _t->selectedDate(); break;
        case 3: *reinterpret_cast<QVariantList*>(_v) = _t->filteredNotes(); break;
        case 4: *reinterpret_cast<QVariantList*>(_v) = _t->filteredMetrics(); break;
        case 5: *reinterpret_cast<QStringList*>(_v) = _t->allMetricNames(); break;
        default: break;
        }
    }
}

const QMetaObject *Controller::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Controller::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN10ControllerE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Controller::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 20)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 20;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 20)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 20;
    }
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    }
    return _id;
}

// SIGNAL 0
void Controller::displayedYearChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void Controller::systemDateChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void Controller::selectedDateChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void Controller::filteredNotesChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void Controller::filteredMetricsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void Controller::allMetricNamesChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void Controller::metricsUpdated()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}
QT_WARNING_POP
