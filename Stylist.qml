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

    Button {
        id: button
        x: 468
        y: 398
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
            print(stylistName)
            Service.logoff_stylist(stylistName,function(resp) {
                print('handle get stylists resp: ' + JSON.stringify(resp));
            });
            stackView.push("Home.qml");
        }
    }

    Button {
        id: button2
        x: 567
        y: 78
        width: 219
        height: 61
        text: qsTr("Show My Jobs")
        font.bold: true
        font.pointSize: 18
        font.family: "Times New Roman"
        palette {
            button: "#ffa07a"
        }
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

    Button {
        id: button1
        x: 252
        y: 398
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
            Service.ready_stylist(stylistName,function(resp) {
            print('handle get stylists resp: ' + JSON.stringify(resp));
            });
            stackView.push("Waiting.qml",{stylistName : stylistName})
        }
    }

    Label {
        id: label
        x: 297
        y: 27
        text: qsTr("Hello")
        color: "#4896e2"
        font.bold: true
        font.pointSize: 30
        font.family: "Times New Roman"

    }

    Label {
        id: label1
        x: 425
        y: 27
        text: qsTr("Label")
        color: "#4896e2"
        font.bold: true
        font.pointSize: 30
        font.family: "Times New Roman"

    }
    Rectangle {
        id: element1
        x: 16
        y: 138
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
