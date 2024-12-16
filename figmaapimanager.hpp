#ifndef FIGMAAPIMANAGER_HPP
#define FIGMAAPIMANAGER_HPP

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QSettings>
#include <qqml.h>

class FigmaAPIManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit FigmaAPIManager(QObject *parent = nullptr);

    Q_INVOKABLE void fetchFigmaFile(const QString &fileKey, const QString &accessToken);
    Q_INVOKABLE QString getLastFileKey() const;
    Q_INVOKABLE QString getLastAccessToken() const;

signals:
    void figmaFileFetched(const QString &fileContent);

private slots:
    void onResult(QNetworkReply *reply);

private:
    QNetworkAccessManager *networkManager;
    QSettings m_settings;
};

#endif // FIGMAAPIMANAGER_HPP
