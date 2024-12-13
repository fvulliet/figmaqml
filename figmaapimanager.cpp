#include "figmaapimanager.hpp"
#include <QJsonDocument>
#include <QJsonObject>
#include <QDebug>

FigmaAPIManager::FigmaAPIManager(QObject *parent) : QObject(parent) {
    networkManager = new QNetworkAccessManager(this);
    connect(networkManager, &QNetworkAccessManager::finished, this, &FigmaAPIManager::onResult);
}

void FigmaAPIManager::fetchFigmaFile(const QString &fileKey, const QString &accessToken) {
    QUrl url(QString("https://api.figma.com/v1/files/%1").arg(fileKey));
    QNetworkRequest request(url);
    request.setRawHeader("X-Figma-Token", accessToken.toUtf8());

    networkManager->get(request);
}

void FigmaAPIManager::onResult(QNetworkReply *reply) {
    if (reply->error() == QNetworkReply::NoError) {
        QByteArray response = reply->readAll();
        QJsonDocument jsonDoc = QJsonDocument::fromJson(response);
        if (!jsonDoc.isNull()) {
            QString jsonString = QString::fromUtf8(jsonDoc.toJson());
            qDebug() << "Figma file response: " << jsonString;
            emit figmaFileFetched(jsonString);  // Emit signal to QML
        } else {
            qDebug() << "Error parsing JSON response.";
        }
    } else {
        qDebug() << "Error:" << reply->errorString();
    }
    reply->deleteLater();
}
