import QtQuick 2.12
import QtQuick.Controls 2.5
import "HttpService.js" as Service

Rectangle {
    property alias stylistName: label1.text
    width: 800
    height: 480
    color: "#fef0f0"

    property var  header: [ // widths must add to 1
        {text: 'ID',     width: 0.1},
        {text: 'Stylist',   width: 0.225},
        {text: 'Customer',   width: 0.225},
        {text: 'Type',   width: 0.225},
        {text: 'Status',   width: 0.225},
    ]

    FButton {
        id: button
        x: 418
        y: 372
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
                    job.push(resp[i]["ID"]);
                    job.push(resp[i]["Stylist"]);
                    job.push(resp[i]["Customer"]);
                    job.push(resp[i]["Type"]);
                    job.push(resp[i]["Status"]);
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
        x: 253
        y: 372
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
        x: 107
        y: 33
        text: qsTr("سلام خوش آمدید!")
        color: "#4896e2"
        font.bold: true
        font.pointSize: 30
        font.family: "B Roya"

    }

    Label {
        id: label1
        x: 367
        y: 44
        text: qsTr("Label")
        color: "#4896e2"
        font.bold: true
        font.pointSize: 30
        font.family: "B Roya"

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

}
