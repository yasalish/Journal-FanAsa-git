import QtQuick 2.12
import QtQuick.Controls 2.5
import "HttpService.js" as Service

Rectangle {
    width: 800
    height: 480
    color: "#feecec"
    Label {
        color: "#619eda"
        text: qsTr("مدیر سالن خوش آمدید!")
        anchors.verticalCenterOffset: -102
        anchors.horizontalCenterOffset: -5
        font.bold: true
        font.family: "B Roya"
        font.pointSize: 30
        anchors.centerIn: parent
    }
    FButton {
        id: button
        x: 219
        y: 222
        bText:"پایان"
        onClicked: {            
            Service.logoff_stylist("Manager",function(resp) {
            print('handle get stylists resp: ' + JSON.stringify(resp));
            });
            stackView.push("Home.qml");
        }
    }
    FButton {
        id: button1
        x: 459
        y: 222
        bText: "شروع"
        onClicked: {
            Service.ready_stylist("Manager",function(resp) {
            print('handle get stylists resp: ' + JSON.stringify(resp));
            });
            stackView.push("ManagerList.qml");
        }
    }

}
