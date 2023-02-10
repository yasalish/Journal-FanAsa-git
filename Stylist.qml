import QtQuick 2.12
import QtQuick.Controls 2.5
import "HttpService.js" as Service

Rectangle {
    property alias stylistName: label1.text
    width: 800
    height: 480
    color: "#fef0f0"

    property var  header: [ // widths must add to 1
        {text: 'صف',     width: 0.1},
        {text: 'وضعیت',   width: 0.2},
        {text: 'خدمت',   width: 0.2},
        {text: 'مشتری',   width: 0.175},
        {text: 'آرایشگر',   width: 0.175},
        {text: 'شماره',   width: 0.15},
    ]

    FButton {
        id: button
        x: 238
        y: 375
        bText:"پایان"
        onClicked: {
            print(stylistName)
            Service.logoff_stylist(stylistName,function(resp) {
                print('handle get stylists resp: ' + JSON.stringify(resp));
            });
            stackView.push("Home.qml");
        }
    }

    FButton {
        id: button2
        x: 621
        y: 74
        bText:"کارهای من"
        onClicked: {
            Service.get_job_name(stylistName,function(resp) {
            print('handle get stylists resp: ' + JSON.stringify(resp));
                var jobs=[];
                for(var i=0;i<resp.length;i++)
                {
                    var job=[]
                    job.push(resp[i]["QNumber"]);
                    job.push(resp[i]["Status"]);
                    job.push(resp[i]["Type"]);
                    job.push(resp[i]["Customer"]);
                    job.push(resp[i]["Stylist"]);
                    job.push(resp[i]["ID"]);
                    jobs.push(job);
                }
                table1.dataModel=jobs
                table1.headerModel=header
                element1.visible=true
            });
        }
    }

    FButton {
        id: button1
        x: 406
        y: 375
        bText:"شروع"
        onClicked: {
            Service.ready_stylist(stylistName,function(resp) {
            print('handle get stylists resp: ' + JSON.stringify(resp));
            });
            stackView.push("Waiting.qml",{stylistName : stylistName})
        }
    }

    Label {
        id: label
        x: 215
        y: 8
        text: label1.text+" خوش آمدی!"
        color: "#4896e2"
        font.bold: true
        font.pointSize: 30
        font.family: "B Roya"
    }
    Label {
        id: label1
        x: 419
        y: 8
        text: qsTr("Label")
        color: "#4896e2"
        font.bold: true
        font.pointSize: 30
        font.family: "B Roya"
        visible:false
    }
    Rectangle {
        id: element1
        x: 20
        y: 105
        width: 559
        height: 249
        visible: false
        Table {
            id:table1
            anchors.fill: parent
            onClicked: {
                print('onClicked', row, JSON.stringify(rowData))
            }
        }
    }

    Rectangle {
        id: stylistStatus
        x: 635
        y: 202
        width: 98
        height: 76
        color: "blue"
        radius: 32
    }

    Rectangle {
        id: stylistQueue
        x: 635
        y: 312
        width: 98
        height: 76
        color: "#ffffff"
        radius: 32
    }
    SequentialAnimation {
            loops: Animation.Infinite
            running: true
            OpacityAnimator {
                        target: stylistStatus
                        from: 0.5
                        to: 1
                        duration: 500
                    }
            OpacityAnimator {
                        target: stylistStatus
                        from: 1
                        to: 0.5
                        duration: 500
            }
    }
    SequentialAnimation {
            loops: Animation.Infinite
            running: true
            OpacityAnimator {
                        target: stylistQueue
                        from: 0.5
                        to: 1
                        duration: 500
                    }
            OpacityAnimator {
                        target: stylistQueue
                        from: 1
                        to: 0.5
                        duration: 500
            }
    }

    Label {
        id: label2
        x: 635
        y: 167
        width: 80
        height: 13
        color: "#a60dd4"
        text: qsTr("وضعیت")
        font.pointSize: 18
        font.family: "B Roya"
        font.bold: true
    }

    Label {
        id: label3
        x: 621
        y: 279
        width: 80
        height: 13
        color: "#a60dd4"
        text: qsTr("صف")
        font.family: "B Roya"
        font.pointSize: 18
        font.bold: true
    }
    Component.onCompleted: {
        Service.get_stylist_name(stylistName,function(resp) {
        print('handle get stylists resp:**** ' + JSON.stringify(resp))
           if(resp["QPerson"]===0)
               stylistQueue.color="green"
           else
               stylistQueue.color="red"
        });
        }

}
