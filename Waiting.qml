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
        anchors.verticalCenterOffset: -127
        anchors.horizontalCenterOffset: horizontalCenter
        font.bold: true
        font.pointSize: 24
        font.family: "Times New Roman"
        anchors.centerIn: parent
        visible: false
    }
    Text {
        id: element
        x: 254
        y: 54
        color: "#0d6583"
        text: "Waiting for a job!"
        font.bold: true
        font.pointSize: 28
        font.family: "Times New Roman"
        font.pixelSize: 36

    }

    BusyIndicator {
        id: busyIndicator
        x: 273
        y: 179
        width: 255
        height: 158
    }
    Button {
        id: button
        x: 652
        y: 327
        width: 115
        height: 64
        text: qsTr("Back")
        font.family: "Times New Roman"
        font.bold: true
        font.pointSize: 20
        palette {
               button: "#ffa07a"
           }
        onClicked: {
            stackView.push("Stylist.qml",{stylistName : stylistName});
        }
    }

}
