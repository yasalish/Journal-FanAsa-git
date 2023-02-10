import QtQuick 2.12
import QtQuick.Controls 2.5
import "HttpService.js" as Service

Rectangle {
    width: 800
    height: 480
    /*
    property var  header: [ // widths must add to 1
        {text: 'ID',     width: 0.1},
        {text: 'Stylist',   width: 0.175},
        {text: 'Customer',   width: 0.2},
        {text: 'Type',   width: 0.175},
        {text: 'Status',   width: 0.175},
        {text: 'Queue',   width: 0.175},
    ]  
   */
    property var  header: [ // widths must add to 1
        {text: 'صف',     width: 0.1},
        {text: 'وضعیت',   width: 0.2},
        {text: 'خدمت',   width: 0.2},
        {text: 'مشتری',   width: 0.175},
        {text: 'آرایشگر',   width: 0.175},
        {text: 'شماره',   width: 0.15},
    ]
    color: "#fef0f0"
    border.color: "#221919"
    FButton {
        id: button
        x: 363
        y: 15
        bText:"تمام کارها"
        onClicked: {
            Service.get_jobs(function(resp) {
            print('handle get jobs resp: ' + JSON.stringify(resp));
                var jobs=[];
                for(var i=0;i<resp.length;i++)
                {
                    var job=[]
                    /*
                    job.push(resp[i]["ID"]);
                    job.push(resp[i]["Stylist"]);
                    job.push(resp[i]["Customer"]);
                    job.push(resp[i]["Type"]);
                    job.push(resp[i]["Status"]);
                    job.push(resp[i]["QNumber"]);
                    */
                    job.push(resp[i]["QNumber"]);
                    job.push(resp[i]["Status"]);
                    job.push(resp[i]["Type"]);
                    job.push(resp[i]["Customer"]);
                    job.push(resp[i]["Stylist"]);
                    job.push(resp[i]["ID"]);
                    jobs.push(job);
                }
                print(jobs)
                table1.dataModel=jobs
                element1.visible=true
             });
        }
    }
    FButton {
        id: button2
        x: 218
        y: 15
        bText:"کار"
        onClicked: {            
            var jobid=textInput.text;
            Service.get_job(jobid,function(resp) {
            print('handle get jobs resp: ' + JSON.stringify(resp));
            var jobs=[]
            var job=[]
            /*
            job.push(resp["ID"]);
            job.push(resp["Stylist"]);
            job.push(resp["Customer"]);
            job.push(resp["Type"]);
            job.push(resp["Status"]);
            job.push(resp["QNumber"]);
            */

            job.push(resp["QNumber"]);
            job.push(resp["Status"]);
            job.push(resp["Type"]);
            job.push(resp["Customer"]);
            job.push(resp["Stylist"]);
            job.push(resp["ID"]);

            print(job)
            jobs.push(job);
            element1.visible=false
            table2.dataModel=jobs
            element2.visible=true
            });
        }
    }
    FButton {
        id: button3
        x: 32
        y: 15
        bText:"تخصیص کار"
        onClicked: {
            var jobid=textInput.text;
            Service.assign_job(jobid,function(resp) {
            print('handle get jobs resp: ' + JSON.stringify(resp));
            var jobs=[]
            var job=[]

            job.push(resp["QNumber"]);
            job.push(resp["Status"]);
            job.push(resp["Type"]);
            job.push(resp["Customer"]);
            job.push(resp["Stylist"]);
            job.push(resp["ID"]);

            print(job)
            jobs.push(job);
            element1.visible=false
            table2.dataModel=jobs
            element2.visible=true
            });
        }
    }
    FButton {
        id: button4
        x: 608
        y: 379
        bText:"بازگشت"
        onClicked: {
            stackView.push("ManagerList.qml");
        }
    }
    Rectangle {
        id: element1
        x: 16
        y: 120
        width: 559
        height: 300
        visible: false
        Table {
            id:table1
            anchors.fill: parent
            headerModel: header
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
                headerModel: header
                onClicked: print('onClicked', row, JSON.stringify(rowData))
            }
        }

    Rectangle {
        id: rectangle
        x: 548
        y: 53
        width: 123
        height: 37
        color: "#feebeb"
        radius: 10
        border.color: "#e6dede"
        TextInput {
            id: textInput
            color: "#a60dd4"
            anchors.fill:parent
            anchors.centerIn: parent
            text: qsTr("1")
            anchors.verticalCenterOffset: 15
            anchors.horizontalCenterOffset: -8
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 30
            anchors.bottomMargin: 0
            font.bold: true
            font.family: "B Roya"
            font.pixelSize: 28
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    NumberPad {
        id: numberPad
        y: 96
        width: 125
        height: 100
        anchors.horizontalCenterOffset: 251
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
                if(value>=0 && value<=9)
                {
                      textInput.text += value;
                }
                else if(value==11)
                {
                    textInput.text += ".";
                }
                else
                {
                      var st = ''
                      for(var i=0;i<textInput.length-1;i++)
                          st += textInput.text[i]
                      textInput.text=st
                      console.log(st)

                }
        }
    }
Label {
        id: label
        x: 553
        y: 15
        width: 123
        height: 20
        text: qsTr("شماره کار")
        font.pointSize: 17
        font.bold: true
        font.family: "B Roya"
        horizontalAlignment: Text.AlignHCenter
    }
}
