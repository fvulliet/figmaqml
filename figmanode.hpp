#ifndef FIGMANODE_HPP
#define FIGMANODE_HPP

#include <QObject>
#include <QJsonObject>

class FigmaNode : public QObject
{
    Q_OBJECT

public:
    explicit FigmaNode(QString name, QJsonObject obj, QObject *parent = nullptr);

    QString key() const;
    QJsonObject jsObj() const;

private:
    QString m_key;
    QJsonObject m_jsObj;
};

#endif // FIGMANODE_HPP
