#include "figmadocument.hpp"
#include "figmanode.hpp"
#include <QJsonDocument>
#include <QJsonObject>

FigmaDocument::FigmaDocument(QObject *parent)
{

}

void FigmaDocument::fill(const QString &txt)
{
    QJsonDocument jsDoc = QJsonDocument::fromJson(txt.toUtf8());

    if (!jsDoc.isObject())
        return;

    QJsonObject topJsObj = jsDoc.object();
    QStringList keys = topJsObj.keys();

    for (const QString& key : keys) {
        if (topJsObj.value(key).isObject()) {
            FigmaNode* node = new FigmaNode(key, topJsObj.value(key).toObject());
            m_nodes.append(node);
        }
    }
}

QStringList FigmaDocument::getNodesList() const
{
    QStringList list;
    for (const FigmaNode* node : m_nodes) {
        list.append(node->key());
    }
    return list;
}

QString FigmaDocument::getNodeContent(const QString &key) const
{
    for (const FigmaNode* node : m_nodes) {
        if (node->key() == key) {
            QJsonDocument jsDoc(node->jsObj());
            return jsDoc.toJson(QJsonDocument::Indented);
        }
    }
    return QString();
}
