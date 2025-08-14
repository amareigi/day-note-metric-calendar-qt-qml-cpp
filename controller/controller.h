#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QDate>
#include <QVariantList>
#include <QVariantMap>
#include <QStringList>

#include "../model/model.h"
#include "DatabaseManager.h" // Include our new database class

class Controller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int displayedYear READ displayedYear NOTIFY displayedYearChanged)
    Q_PROPERTY(QDate systemDate READ systemDate NOTIFY systemDateChanged)
    Q_PROPERTY(QDate selectedDate READ selectedDate NOTIFY selectedDateChanged)
    Q_PROPERTY(QVariantList filteredNotes READ filteredNotes NOTIFY filteredNotesChanged)
    Q_PROPERTY(QVariantList filteredMetrics READ filteredMetrics NOTIFY filteredMetricsChanged)
    Q_PROPERTY(QStringList allMetricNames READ allMetricNames NOTIFY allMetricNamesChanged)

public:
    explicit Controller(QObject *parent = nullptr, Model* model = nullptr);

    // --- Getters ---
    int displayedYear() const;
    QDate systemDate() const;
    QDate selectedDate() const;
    QVariantList filteredNotes() const;
    QVariantList filteredMetrics() const;
    QStringList allMetricNames() const;

public slots:
    void nextYear();
    void prevYear();
    void selectDate(QDate newSelectedDate);
    double averageRatingForDate(const QString &isoDate);
    void addNote(const QString &content);
    void removeLastNote();
    void removeNoteById(int id);
    void updateNoteContent(int id, const QString &newContent);
    void addMetric(const QString &name, int rating);
    void removeLastMetric();
    void removeMetricById(int id);
    void updateMetricName(int id, const QString &newName);
    void updateMetricRating(int id, int newRating);

signals:
    void displayedYearChanged();
    void systemDateChanged();
    void selectedDateChanged();
    void filteredNotesChanged();
    void filteredMetricsChanged();
    void allMetricNamesChanged();
    void metricsUpdated();

private:
    void updateFilteredNotes();
    void updateFilteredMetrics();
    void loadInitialData();

    Model* m_calendarModel;
    DatabaseManager* m_dbManager; // Use a pointer to the new database manager

    int m_displayedYear;
    QDate m_systemDate;
    QDate m_selectedDate;
    QVariantList m_notes;
    QVariantList m_filteredNotes;
    QVariantList m_metrics;
    QVariantList m_filteredMetrics;
    QStringList m_allMetricNames;
};

#endif // CONTROLLER_H
