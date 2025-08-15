#ifndef MODEL_H
#define MODEL_H

#include <QAbstractListModel>
#include <QDate>
#include <QVector>
#include <QVariantMap>
// на будущее, сюда перенести методы из controller
class Model : public QObject
{
    Q_OBJECT
public:

    explicit Model(QObject *parent = nullptr)
    {

    }
    ~Model() = default;

signals:


private:


};

#endif // MODEL_H
