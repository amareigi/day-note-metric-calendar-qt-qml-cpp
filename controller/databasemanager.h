#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDate>
#include <QVariantList>
#include <QVariantMap>
#include <QDebug>

class DatabaseManager : public QObject
{
    Q_OBJECT

public:
    explicit DatabaseManager(QObject *parent = nullptr);
    ~DatabaseManager();

    // Database initialization
    bool initDatabase();
    void createTablesIfNeeded();

    // Note operations
    QVariantList loadNotes();
    int insertNote(const QString& dateStr, const QString& content);
    bool deleteNoteById(int id);
    bool updateNoteContent(int id, const QString& newContent);

    // Metric operations
    QVariantList loadMetrics();
    int insertMetric(const QString& dateStr, const QString& name, int rating);
    bool deleteMetricById(int id);
    bool updateMetricName(int id, const QString& newName);
    bool updateMetricRating(int id, int newRating);
    QStringList loadAllMetricNames();

private:
    QSqlDatabase m_db;
    QString m_connectionName = "notes-metrics-connection";
};

#endif // DATABASEMANAGER_H
