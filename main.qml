import QtQuick 2.12
import QtQuick.Controls 2.5
import FileIO 1.0
import SerialPort 1.0
import "MifareMethods.js" as Mifare


ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 480
    title: qsTr("FanAsa")

    property var serPort : ""
    property var ipAddress : ""
    property var bASE : "http://"+ipAddress+":5000/"
    property var bASE1 : bASE+"jobs";
    property var bASE2 : bASE+"stylists";
    property var bASE3 : bASE+"login";
    property var bASE4 : bASE+"logoff";

    property var bASEws: "ws://"+ipAddress+":5000/stylist"
    property var rcount: 0
    property var rdata:""
    property var code:""
    property var keys : [   "ffffffffffff",
                            "a0b0c0d0e0f0",
                            "a1b1c1d1e1f1",
                            "a0a1a2a3a4a5",
                            "b0b1b2b3b4b5",
                            "4d3a99c351dd",
                            "1a982c7e459a",
                            "000000000000",
                            "aabbccddeeff",
                            "d3f7d3f7d3f7",
                            "aabbccddeeff",
                            "714c5c886e97",
                            "587ee5f9350f",
                            "a0478cc39091",
                            "533cb6c723f6",
                            "8fd0a4f256e9"
                         ]



    Component.onCompleted: {
        print("MAIN IP Address = ",ipAddress,"Serial Port = ",serPort)
            }

    StackView {
        id: stackView
        initialItem: "Home.qml"
        anchors.fill: parent
    }
}
