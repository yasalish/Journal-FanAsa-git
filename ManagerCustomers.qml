import QtQuick 2.12
import QtQuick.Controls 2.5
import "HttpService.js" as Service

Rectangle {
    width: 800
    height: 480
    property var  header: [ // widths must add to 1
        {text: 'ID',     width: 0.15},
        {text: 'Customer',   width: 0.225},
        {text: 'Stylist',   width: 0.2},
        {text: 'Queue',   width: 0.15},
        {text: 'WaitingTime', width: 0.275},
    ]

    color: "#fef0f0"
    border.color: "#221919"
    FButton {
        id: button
        x: 210
        y: 25
        scale: 1
        bText:"لیست انتظار مشتریان"
        width:150
        onClicked: {
            Service.get_jobs(function(resp) {
            print('handle get stylists resp: ' + JSON.stringify(resp));
                var jobs=[];
                for(var i=0;i<resp.length;i++)
                {

                    if(resp[i]["Status"]==="Assigned")
                    {
                        var job=[]
                        job.push(resp[i]["ID"]);
                        job.push(resp[i]["Customer"]);
                        job.push(resp[i]["Stylist"]);
                        job.push(resp[i]["QNumber"]);
                        job.push(resp[i]["QWating"]);
                        jobs.push(job);
                    }
                }
                print(jobs)
                table1.headerModel=header
                table1.dataModel=jobs
                element1.visible=true
             });
        }
    }
    FButton {
        id: button4
        x: 660
        y: 377
        bText:"بازگشت"
        onClicked: {
            stackView.push("ManagerList.qml");
        }
    }
    Rectangle {
        id: element1
        x: 16
        y: 120
        width: 600
        height: 300
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
            id: element2
            x: 16
            y: 120
            width: 559
            height: 118
            visible: false
            Table {
                id:table2
                anchors.fill: parent
                onClicked: print('onClicked', row, JSON.stringify(rowData))
            }
        }
}
