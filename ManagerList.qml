import QtQuick 2.12
import QtQuick.Controls 2.5
Rectangle {
    width: 800
    height: 480    

    color: "#fef0f0"
    border.color: "#221919"
    FButton {
        id: button
        x: 154
        y: 163
        bText: "کار"
        onClicked: {
            stackView.push("ManagerJobs.qml");
        }
    }
    FButton {
        id: button2
        x: 345
        y: 163
        bText: "آرایشگر"
        onClicked: {
            stackView.push("ManagerStyle.qml");
        }
    }

    FButton {
        id: button3
        x: 553
        y: 163
        bText: "مشتری"
        onClicked: {
            stackView.push("ManagerCustomers.qml");
        }
    }


    FButton {
        id: button4
        x: 624
        y: 362
        bText: "بازگشت"
        onClicked: {
            stackView.push("Manager.qml");
        }
    }

}
