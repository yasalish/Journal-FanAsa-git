import QtQuick 2.12
import QtQuick.Controls 2.5

Rectangle {
    property alias stylistName: label1.text
    width: 800
    height: 480
    color: "#fef0f0"
    Label {
        id:label1
        color: "#4896e2"
        //text: "Hello "+"!"
        anchors.verticalCenterOffset: -140
        anchors.horizontalCenterOffset: horizontalCenter
        font.bold: true
        font.pointSize: 24
        font.family: "Times New Roman"
        anchors.centerIn: parent
    }
    Button {
        id: button
        x: 461
        y: 230
        width: 115
        height: 64
        text: qsTr("Stop")
        font.family: "Times New Roman"
        font.bold: true
        font.pointSize: 20
        palette {
               button: "#ffa07a"
           }
        onClicked: {
            stackView.push("Home.qml");
        }
    }

    Button {
        id: button1
        x: 223
        y: 230
        width: 120
        height: 64
        text: qsTr("Start")
        font.bold: true
        font.pointSize: 20
        font.family: "Times New Roman"
        palette {
               button: "#ffa07a"
           }
        onClicked: {
            stackView.push("Waiting.qml",{stylistName : stylistName})
        }
    }
}
