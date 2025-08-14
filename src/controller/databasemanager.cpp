#include "DatabaseManager.h"

DatabaseManager::DatabaseManager(QObject *parent)
    : QObject(parent)
{
}

DatabaseManager::~DatabaseManager()
{
    if (m_db.isOpen()) {
        m_db.close();
        QSqlDatabase::removeDatabase(m_connectionName);
        qDebug() << "Database connection closed and removed.";
    }
}

bool DatabaseManager::initDatabase()
{
    if (QSqlDatabase::contains(m_connectionName)) {
        m_db = QSqlDatabase::database(m_connectionName);
    } else {
        m_db = QSqlDatabase::addDatabase("QSQLITE", m_connectionName);
        m_db.setDatabaseName("notes_metrics.db");
    }

    if (!m_db.open()) {
        qWarning() << "SQLite open failed:" << m_db.lastError().text();
        return false;
    }
    qDebug() << "SQLite open ok:" << m_db.databaseName();
    createTablesIfNeeded();
    return true;
}

void DatabaseManager::createTablesIfNeeded()
{
    if (!m_db.isOpen()) return;

    QSqlQuery notesQuery(m_db);
    const char* notesDdl =
        "CREATE TABLE IF NOT EXISTS notes ("
        "  id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "  date TEXT NOT NULL,"
        "  content TEXT NOT NULL"
        ")";
    if (!notesQuery.exec(QString::fromUtf8(notesDdl))) {
        qWarning() << "CREATE TABLE notes failed:" << notesQuery.lastError().text();
    }

    QSqlQuery metricsQuery(m_db);
    const char* metricsDdl =
        "CREATE TABLE IF NOT EXISTS metrics ("
        "  id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "  date TEXT NOT NULL,"
        "  name TEXT NOT NULL,"
        "  rating INTEGER NOT NULL CHECK(rating >= 1 AND rating <= 10)"
        ")";
    if (!metricsQuery.exec(QString::fromUtf8(metricsDdl))) {
        qWarning() << "CREATE TABLE metrics failed:" << metricsQuery.lastError().text();
    }
}

QVariantList DatabaseManager::loadNotes()
{
    QVariantList notes;
    if (!m_db.isOpen()) return notes;

    QSqlQuery q(m_db);
    if (!q.exec("SELECT id, date, content FROM notes ORDER BY id ASC")) {
        qWarning() << "SELECT notes failed:" << q.lastError().text();
        return notes;
    }

    while (q.next()) {
        QVariantMap note;
        note["id"] = q.value(0).toInt();
        note["date"] = q.value(1).toString();
        note["content"] = q.value(2).toString();
        notes.append(note);
    }
    return notes;
}

int DatabaseManager::insertNote(const QString& dateStr, const QString& content)
{
    if (!m_db.isOpen()) return -1;

    QSqlQuery q(m_db);
    q.prepare("INSERT INTO notes(date, content) VALUES(?, ?)");
    q.addBindValue(dateStr);
    q.addBindValue(content);
    if (!q.exec()) {
        qWarning() << "INSERT note failed:" << q.lastError().text();
        return -1;
    }
    return q.lastInsertId().toInt();
}

bool DatabaseManager::deleteNoteById(int id)
{
    if (!m_db.isOpen()) return false;

    QSqlQuery q(m_db);
    q.prepare("DELETE FROM notes WHERE id = ?");
    q.addBindValue(id);
    if (!q.exec()) {
        qWarning() << "DELETE note failed:" << q.lastError().text();
        return false;
    }
    return q.numRowsAffected() >= 0;
}

bool DatabaseManager::updateNoteContent(int id, const QString& newContent)
{
    if (!m_db.isOpen()) return false;

    QSqlQuery q(m_db);
    q.prepare("UPDATE notes SET content = ? WHERE id = ?");
    q.addBindValue(newContent);
    q.addBindValue(id);
    if (!q.exec()) {
        qWarning() << "UPDATE note failed:" << q.lastError().text();
        return false;
    }
    return true;
}

QVariantList DatabaseManager::loadMetrics()
{
    QVariantList metrics;
    if (!m_db.isOpen()) return metrics;

    QSqlQuery q(m_db);
    if (!q.exec("SELECT id, date, name, rating FROM metrics ORDER BY id ASC")) {
        qWarning() << "SELECT metrics failed:" << q.lastError().text();
        return metrics;
    }

    while (q.next()) {
        QVariantMap metric;
        metric["id"] = q.value(0).toInt();
        metric["date"] = q.value(1).toString();
        metric["name"] = q.value(2).toString();
        metric["rating"] = q.value(3).toInt();
        metrics.append(metric);
    }
    return metrics;
}

int DatabaseManager::insertMetric(const QString &dateStr, const QString &name, int rating)
{
    if (!m_db.isOpen()) return -1;

    QSqlQuery q(m_db);
    q.prepare("INSERT INTO metrics(date, name, rating) VALUES(?, ?, ?)");
    q.addBindValue(dateStr);
    q.addBindValue(name);
    q.addBindValue(rating);
    if (!q.exec()) {
        qWarning() << "INSERT metric failed:" << q.lastError().text();
        return -1;
    }
    return q.lastInsertId().toInt();
}

bool DatabaseManager::deleteMetricById(int id)
{
    if (!m_db.isOpen()) return false;

    QSqlQuery q(m_db);
    q.prepare("DELETE FROM metrics WHERE id = ?");
    q.addBindValue(id);
    if (!q.exec()) {
        qWarning() << "DELETE metric failed:" << q.lastError().text();
        return false;
    }
    return q.numRowsAffected() >= 0;
}

bool DatabaseManager::updateMetricName(int id, const QString &newName)
{
    if (!m_db.isOpen()) return false;

    QSqlQuery q(m_db);
    q.prepare("UPDATE metrics SET name = ? WHERE id = ?");
    q.addBindValue(newName);
    q.addBindValue(id);
    if (!q.exec()) {
        qWarning() << "UPDATE metric name failed:" << q.lastError().text();
        return false;
    }
    return true;
}

bool DatabaseManager::updateMetricRating(int id, int newRating)
{
    if (!m_db.isOpen()) return false;

    QSqlQuery q(m_db);
    q.prepare("UPDATE metrics SET rating = ? WHERE id = ?");
    q.addBindValue(newRating);
    q.addBindValue(id);
    if (!q.exec()) {
        qWarning() << "UPDATE metric rating failed:" << q.lastError().text();
        return false;
    }
    return true;
}

QStringList DatabaseManager::loadAllMetricNames()
{
    QStringList names;
    if (!m_db.isOpen()) return names;

    QSqlQuery q(m_db);
    if (!q.exec("SELECT DISTINCT name FROM metrics ORDER BY name ASC")) {
        qWarning() << "SELECT DISTINCT metric names failed:" << q.lastError().text();
        return names;
    }
    while (q.next()) {
        names.append(q.value(0).toString());
    }
    return names;
}
