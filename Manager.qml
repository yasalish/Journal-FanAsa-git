import QtQuick 2.12
import QtQuick.Controls 2.5

Rectangle {
    width: 800
    height: 480
    color: "#feecec"
    Label {
        color: "#619eda"
        text: qsTr("Hello Salon Manager!")
        anchors.verticalCenterOffset: -102
        anchors.horizontalCenterOffset: -5
        font.bold: true
        font.family: "Times New Roman"
        font.pointSize: 20
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
            stackView.push("ManagerList.qml");
        }
    }

}
