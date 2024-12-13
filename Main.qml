import QtQuick
import QtQuick.Controls

Window {
    id: root

    width: 1600
    height: 1280
    visible: true
    title: "Figma API Example - Qt6"

    property alias _fileKey: fileKeyTextInput.text
    property string _accessToken: accessTokenTextInput.text

    FigmaAPIManager {
        id: figmaAPIManager
    }

    FigmaDocument {
        id: figmaDocument
    }

    Connections {
        target: figmaAPIManager
        function onFigmaFileFetched(fileContent) {
            figmaDocument.fill(fileContent);
            nodesList.model = figmaDocument?.getNodesList();
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#2e2e2e"

        Column {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 16

            Button {
                id: button
                text: "Fetch Figma File"
                onClicked: figmaAPIManager.fetchFigmaFile(_fileKey, _accessToken);
            }

            Row {
                id: info
                width: parent.width
                height: 30
                spacing: 20

                Rectangle {
                    color: "#f1f2fc"
                    height: parent.height
                    width: fileKeyRow.implicitWidth

                    Row {
                        id: fileKeyRow
                        height: parent.height
                        width: fileKeyText.implicitWidth + fileKeyTextInput.width
                        spacing: 8

                        Text {
                            id: fileKeyText
                            height: parent.height
                            text: "File key:"
                            color: "black"
                            verticalAlignment: Text.AlignVCenter
                        }
                        TextInput {
                            id: fileKeyTextInput
                            height: parent.height; width: 300
                            color: "black"
                            font.pixelSize: 8
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
                Rectangle {
                    color: "#f1f2fc"
                    height: parent.height
                    width: accessTokenRow.implicitWidth

                    Row {
                        id: accessTokenRow
                        height: parent.height
                        width: accessTokenText.implicitWidth + accessTokenTextInput.width
                        spacing: 8

                        Text {
                            id: accessTokenText
                            height: parent.height
                            text: "Access token:"
                            color: "black"
                            verticalAlignment: Text.AlignVCenter
                        }
                        TextInput {
                            id: accessTokenTextInput
                            height: parent.height; width: 300
                            color: "black"
                            font.pixelSize: 8
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            Row {
                width: parent.width
                height: parent.height - 2*parent.spacing - button.height - info.height
                spacing: 16

                Rectangle {
                    height: parent.height
                    width: (parent.width - 2*parent.spacing)/4
                    color: "#f1f2fc"

                    Column {
                        anchors.fill: parent
                        spacing: 8

                        ListView {
                            id: nodesList
                            property int itemHeight: 24
                            width: parent.width
                            height: count * itemHeight
                            delegate: Rectangle {
                                id: del

                                required property var modelData
                                required property int index
                                property bool selected: index === nodesList.currentIndex

                                width: nodesList.width
                                height: nodesList.itemHeight
                                color: selected ? "#2e2e2e" : "transparent"

                                Text {
                                    anchors.fill: parent
                                    anchors.leftMargin: 8
                                    verticalAlignment: Text.AlignVCenter
                                    text: modelData
                                    font.pixelSize: height*3/4
                                    color: del.selected ? "white" : "#2e2e2e"
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            nodesList.currentIndex = index;
                                            nodeDetails.text = figmaDocument?.getNodeContent(modelData);
                                        }
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: separation
                            width: parent.width
                            height: 1
                            color: "#2e2e2e"
                        }
                        Rectangle {
                            id: search
                            width: parent.width*3/4
                            height: 24
                            anchors.horizontalCenter: parent.horizontalCenter
                            radius: 5
                            color: "white"
                            border.width: 1; border.color: "#2e2e2e"

                            Text  {
                                text: "search..."
                                anchors.fill: parent
                                anchors.leftMargin: 8
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                        ScrollView {
                            id: view
                            width: parent.width
                            height: parent.height - nodesList.implicitHeight - separation.height - search.height

                            Text {
                                id: nodeDetails
                                anchors.fill: parent
                                anchors.margins: 8
                            }
                        }
                    }
                }
                Rectangle {
                    height: parent.height
                    width: (parent.width - 2*parent.spacing)/4
                    color: "#f1f2fc"

                    ScrollView {
                        anchors.fill: parent

                        Text {
                            id: outputArea
                            anchors.fill: parent
                            wrapMode: Text.Wrap
                            font.pixelSize: 14
                            color: "black"
                            padding: 10
                        }
                    }
                }
                Rectangle {
                    height: parent.height
                    width: (parent.width - 2*parent.spacing)*2/4
                    color: "#f1f2fc"
                }
            }
        }
    }
}
