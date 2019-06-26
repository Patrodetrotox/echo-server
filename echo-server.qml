import QtQuick 2.9
import QtQuick.Controls 2.2
import QtWebSockets 1.0
// ToDo: import WebSockets

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("WebSocket Echo Server")

    WebSocketServer {
        host: "192.168.0.105"
        port: 20000
        listen: true
        // ToDo: define custom host --
        // ToDo: define custom port --
        // ToDo: activate listening --
        onClientConnected: {
            logArea.postInfo(qsTr("Socket connected."));
            webSocket.onTextMessageReceived.connect(function(message) {
                logArea.postIncomingText(message);
                webSocket.sendTextMessage(message)
                // ToDo: send message back --
            });
            webSocket.onStatusChanged.connect(function() {
                console.log(webSocket.status);
                if (webSocket.status === WebSocket.Closed) {
                    logArea.postInfo(qsTr("Socket disconnected."));
                }
            });
        }
        onErrorStringChanged: logArea.postInfo(qsTr("Server error: %1").arg(errorString))
        // ToDo: test for errors -/-
        Component.onCompleted: logArea.postInfo(qsTr("Server is listening at %1").arg(url))
    }
    ScrollView {
        id: logView
        anchors.fill: parent

        TextArea {
            id: logArea

            function postInfo(message) {
                text += qsTr("INFO: %1\n").arg(message);
            }

            function postIncomingText(message) {
                text += qsTr("INCOMING TEXT: %1\n").arg(message);
            }

            anchors.fill: parent
        }
    }
}
