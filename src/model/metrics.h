#ifndef METRICS_H
#define METRICS_H

// #include <QObject>

// class Metrics : public QObject {
//     Q_OBJECT
//     Q_PROPERTY(int happiness READ happiness WRITE setHappiness NOTIFY happinessChanged)
//     Q_PROPERTY(int productivity READ productivity WRITE setProductivity NOTIFY productivityChanged)

// public:
//     explicit Metrics(QObject *parent = nullptr) : QObject(parent) {}

//     int happiness() const { return m_happiness; }
//     void setHappiness(int value) {
//         if (m_happiness == value) return;
//         m_happiness = value;
//         emit happinessChanged();
//     }

//     int productivity() const { return m_productivity; }
//     void setProductivity(int value) {
//         if (m_productivity == value) return;
//         m_productivity = value;
//         emit productivityChanged();
//     }

// signals:
//     void happinessChanged();
//     void productivityChanged();

// private:
//     int m_happiness = 0;
//     int m_productivity = 0;
// };

#endif // METRICS_H
