import QtQuick 2.12
import QtQuick.Controls 2.5
Rectangle {
    width: 800
    height: 480    

    color: "#fef0f0"
    border.color: "#221919"
    Button {
        id: button
        x: 36
        y: 163
        width: 214
        height: 64
        text: qsTr("Job Page")
        font.family: "Times New Roman"
        font.bold: true
        font.pointSize: 20
        palette {
            button: "#ffa07a"
        }
        onClicked: {
            stackView.push("ManagerJobs.qml");
        }
    }
    Button {
        id: button2
        x: 289
        y: 163
        width: 199
        height: 64
        text: qsTr("Stylist Page")
        font.family: "Times New Roman"
        font.bold: true
        font.pointSize: 20
        palette {
            button: "#ffa07a"
        }
        onClicked: {
            stackView.push("ManagerStyle.qml");
        }
    }

    Button {
        id: button3
        x: 519
        y: 163
        width: 199
        height: 64
        text: qsTr("Customer Page")
        font.family: "Times New Roman"
        font.bold: true
        font.pointSize: 20
        palette {
            button: "#ffa07a"
        }
        onClicked: {
            stackView.push("ManagerCustomers.qml");
        }
    }


    Button {
        id: button4
        x: 685
        y: 366
        width: 95
        height: 40
        text: qsTr("Back")
        font.family: "Times New Roman"
        font.bold: true
        font.pointSize: 20
        palette {
            button: "#ffa07a"
        }
        onClicked: {
            stackView.push("Manager.qml");
        }
    }


}
