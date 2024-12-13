#ifndef FIGMADOCUMENT_HPP
#define FIGMADOCUMENT_HPP

#include <QObject>
#include <qqml.h>

class FigmaNode;

class FigmaDocument : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit FigmaDocument(QObject *parent = nullptr);

    Q_INVOKABLE void fill(const QString& txt);
    Q_INVOKABLE QStringList getNodesList() const;
    Q_INVOKABLE QString getNodeContent(const QString& key) const;

private:
    QVector<FigmaNode*> m_nodes;
};

#endif // FIGMADOCUMENT_HPP
