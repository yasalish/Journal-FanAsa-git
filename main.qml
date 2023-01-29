import QtQuick 2.12
import QtQuick.Controls 2.5
import FileIO 1.0


ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 480
    title: qsTr("FanAsa")

    property var ipAddress : ""
    property var bASE : "http://"+ipAddress+":5000/"
    property var bASE1 : bASE+"jobs";
    property var bASE2 : bASE+"stylists";
    property var bASE3 : bASE+"login";
    property var bASE4 : bASE+"logoff";
    property var bASEws: "ws://"+ipAddress+":5000/stylist"

    FileIO {
        id: myFile
        source: "Configs.json"
        onError: console.log(msg)
    }

    Component.onCompleted: {
            var msg=JSON.parse(myFile.read())
            print("IP Address = ",msg["IPAddr"])
            var ip = msg["IPAddr"]
            ipAddress=ip
            print("IP Address = ",ipAddress)
            }

    StackView {
        id: stackView
        initialItem: "Home.qml"
        anchors.fill: parent
    }
}
