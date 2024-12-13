#include "figmanode.hpp"


FigmaNode::FigmaNode(QString key, QJsonObject obj, QObject *parent) :
    m_key(key),
    m_jsObj(obj)
{
}

QString FigmaNode::key() const
{
    return m_key;
}

QJsonObject FigmaNode::jsObj() const
{
    return m_jsObj;
}
