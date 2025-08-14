#include "Controller.h"

Controller::Controller(QObject *parent, Model* model)
    : QObject(parent),
    m_calendarModel(model),
    m_displayedYear(QDate::currentDate().year()),
    m_systemDate(QDate::currentDate()),
    m_selectedDate(QDate::currentDate())
{
    // 1. Create and initialize the database manager
    m_dbManager = new DatabaseManager(this);
    if (!m_dbManager->initDatabase()) {
        qWarning() << "Failed to initialize database. Application may not function correctly.";
    }

    // 2. Load all data from the database
    loadInitialData();

    // 3. Filter the data for the selected date
    updateFilteredNotes();
    updateFilteredMetrics();
}

void Controller::loadInitialData() {
    m_notes = m_dbManager->loadNotes();
    m_metrics = m_dbManager->loadMetrics();
    m_allMetricNames = m_dbManager->loadAllMetricNames();
}

// --- Getters ---
int Controller::displayedYear() const { return m_displayedYear; }
QDate Controller::systemDate() const { return m_systemDate; }
QDate Controller::selectedDate() const { return m_selectedDate; }
QVariantList Controller::filteredNotes() const { return m_filteredNotes; }
QVariantList Controller::filteredMetrics() const { return m_filteredMetrics; }
QStringList Controller::allMetricNames() const { return m_allMetricNames; }

// --- Slots ---
void Controller::nextYear() {
    m_displayedYear++;
    emit displayedYearChanged();
}

void Controller::prevYear() {
    m_displayedYear--;
    emit displayedYearChanged();
}

void Controller::selectDate(QDate newSelectedDate) {
    m_selectedDate = newSelectedDate;
    emit selectedDateChanged();
    updateFilteredNotes();
    updateFilteredMetrics();
}

double Controller::averageRatingForDate(const QString &isoDate)
{
    const QDate targetDate = QDate::fromString(isoDate, "yyyy-MM-dd");
    if (!targetDate.isValid()) {
        return -1.0;
    }

    int total = 0;
    int count = 0;
    for (const auto& metricVar : m_metrics) {
        QVariantMap metric = metricVar.toMap();
        QDate metricDate = QDate::fromString(metric.value("date").toString(), "yyyy-MM-dd");
        if (metricDate == targetDate) {
            total += metric.value("rating").toInt();
            ++count;
        }
    }

    if (count == 0) return -1.0;
    return static_cast<double>(total) / static_cast<double>(count);
}

void Controller::addNote(const QString &content) {
    const QString dateStr = m_selectedDate.toString("yyyy-MM-dd");

    const int newId = m_dbManager->insertNote(dateStr, content);
    if (newId < 0) {
        qWarning() << "addNote: Failed to insert note into database.";
        return;
    }

    QVariantMap newNote;
    newNote["id"] = newId;
    newNote["date"] = dateStr;
    newNote["content"] = content;
    m_notes.append(newNote);

    updateFilteredNotes();
}

void Controller::removeLastNote() {
    if (m_notes.isEmpty()) return;

    const QVariantMap note = m_notes.last().toMap();
    const int id = note.value("id", -1).toInt();

    if (id >= 0) {
        if (!m_dbManager->deleteNoteById(id)) {
            qWarning() << "removeLastNote: Failed to delete note from database with id=" << id;
            return;
        }
    } else {
        qWarning() << "removeLastNote: Note has no ID, only removing from memory.";
    }

    m_notes.removeLast();
    updateFilteredNotes();
}

void Controller::removeNoteById(int id) {
    if (id < 0) return;

    if (!m_dbManager->deleteNoteById(id)) {
        qWarning() << "Failed to delete note with id=" << id;
        return;
    }

    for (int i = 0; i < m_notes.size(); ++i) {
        QVariantMap note = m_notes[i].toMap();
        if (note.value("id").toInt() == id) {
            m_notes.removeAt(i);
            break;
        }
    }
    updateFilteredNotes();
}

void Controller::updateNoteContent(int id, const QString &newContent) {
    if (id < 0 || !m_dbManager->updateNoteContent(id, newContent)) {
        qWarning() << "Failed to update note content in database.";
        return;
    }

    for (auto &noteVar : m_notes) {
        QVariantMap note = noteVar.toMap();
        if (note["id"].toInt() == id) {
            note["content"] = newContent;
            noteVar = note;
            break;
        }
    }
    updateFilteredNotes();
}

void Controller::addMetric(const QString &name, int rating) {
    const QString dateStr = m_selectedDate.toString("yyyy-MM-dd");

    int newId = m_dbManager->insertMetric(dateStr, name, rating);
    if (newId < 0) {
        qWarning() << "addMetric: Failed to insert metric into database.";
        return;
    }

    QVariantMap metric;
    metric["id"] = newId;
    metric["date"] = dateStr;
    metric["name"] = name;
    metric["rating"] = rating;
    m_metrics.append(metric);

    updateFilteredMetrics();
    m_allMetricNames = m_dbManager->loadAllMetricNames();
    emit allMetricNamesChanged();
    emit metricsUpdated();
}

void Controller::removeLastMetric() {
    if (m_metrics.isEmpty()) return;

    const QVariantMap metric = m_metrics.last().toMap();
    int id = metric.value("id", -1).toInt();

    if (id >= 0 && !m_dbManager->deleteMetricById(id)) {
        qWarning() << "removeLastMetric: Failed to delete metric from database with id=" << id;
        return;
    }

    m_metrics.removeLast();
    updateFilteredMetrics();
    m_allMetricNames = m_dbManager->loadAllMetricNames();
    emit allMetricNamesChanged();
}

void Controller::removeMetricById(int id) {
    if (id < 0) return;

    if (!m_dbManager->deleteMetricById(id)) {
        qWarning() << "Failed to delete metric with id=" << id;
        return;
    }

    for (int i = 0; i < m_metrics.size(); ++i) {
        QVariantMap metric = m_metrics[i].toMap();
        if (metric.value("id").toInt() == id) {
            m_metrics.removeAt(i);
            break;
        }
    }
    updateFilteredMetrics();
    m_allMetricNames = m_dbManager->loadAllMetricNames();
    emit allMetricNamesChanged();
    emit metricsUpdated();
}

void Controller::updateMetricName(int id, const QString &newName) {
    if (id < 0 || newName.trimmed().isEmpty()) return;

    if (!m_dbManager->updateMetricName(id, newName)) {
        qWarning() << "Failed to update metric name in database.";
        return;
    }

    for (auto &metricVar : m_metrics) {
        QVariantMap metric = metricVar.toMap();
        if (metric["id"].toInt() == id) {
            metric["name"] = newName;
            metricVar = metric;
            break;
        }
    }
    updateFilteredMetrics();
    m_allMetricNames = m_dbManager->loadAllMetricNames();
    emit allMetricNamesChanged();
    emit metricsUpdated();
}

void Controller::updateMetricRating(int id, int newRating) {
    if (id < 0 || newRating < 1 || newRating > 10) return;

    if (!m_dbManager->updateMetricRating(id, newRating)) {
        qWarning() << "Failed to update metric rating in database.";
        return;
    }

    for (auto &metricVar : m_metrics) {
        QVariantMap metric = metricVar.toMap();
        if (metric["id"].toInt() == id) {
            metric["rating"] = newRating;
            metricVar = metric;
            break;
        }
    }
    updateFilteredMetrics();
    emit metricsUpdated();
}

// --- Helper functions ---
void Controller::updateFilteredNotes() {
    m_filteredNotes.clear();
    const QString selectedDateStr = m_selectedDate.toString("yyyy-MM-dd");
    for (const auto& noteVar : m_notes) {
        QVariantMap note = noteVar.toMap();
        if (note.value("date").toString() == selectedDateStr) {
            m_filteredNotes.append(noteVar);
        }
    }
    emit filteredNotesChanged();
}

void Controller::updateFilteredMetrics() {
    m_filteredMetrics.clear();
    const QString selectedDateStr = m_selectedDate.toString("yyyy-MM-dd");
    for (const auto& metricVar : m_metrics) {
        QVariantMap metric = metricVar.toMap();
        if (metric.value("date").toString() == selectedDateStr) {
            m_filteredMetrics.append(metricVar);
        }
    }
    emit filteredMetricsChanged();
}
