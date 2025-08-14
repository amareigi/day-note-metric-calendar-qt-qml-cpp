#ifndef MODEL_H
#define MODEL_H

#include <QAbstractListModel>
#include <QDate>
#include <QVector>
#include <QVariantMap>

class Model : public QObject
{
    Q_OBJECT
public:

    explicit Model(QObject *parent = nullptr)
    {
        m_currentDate = QDate::currentDate();
        m_selectedDate = m_currentDate;
    }
    ~Model() = default;

signals:
    void currentDateChanged();
    void selectedDateChanged();

private:
    QDate m_currentDate;      // Текущая дата (год, месяц)
    QDate m_selectedDate;     // Выбранная дата
    QVector<QVariantMap> m_days;  // Список дней (вместо Day*)
};

#endif // MODEL_H
