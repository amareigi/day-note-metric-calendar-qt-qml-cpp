#ifndef DAY_H
#define DAY_H

#include <QObject>
#include <QDate>
//#include "note.h"
//#include "metrics.h"

// class Day : public QObject {
//     Q_OBJECT
//     Q_PROPERTY(QDate date READ date CONSTANT)
//     Q_PROPERTY(Note* note READ note CONSTANT)
//     Q_PROPERTY(Metrics* metrics READ metrics CONSTANT)

// public:
//     // explicit Day(const QDate &date, QObject *parent = nullptr)
//     //    : QObject(parent), m_date(date), m_note(new Note(this)), m_metrics(new Metrics(this)) {}

//     explicit Day(const QDate &date, QObject *parent = nullptr)
//         : QObject(parent), m_date(date) {}

//     QDate date() const { return m_date; }
//     // Note* note() const { return m_note; }
//     // Metrics* metrics() const { return m_metrics; }

// private:
//     QDate m_date;
//     // Note* m_note;
//     // Metrics* m_metrics;
// };

#endif // DAY_H
