import QtQuick 2.12
import QtQuick.Controls 2.5
import "HttpService.js" as Service

Rectangle {
    width: 800
    height: 480
    property var  header: [ // widths must add to 1
        {text: 'ID',     width: 0.1},
        {text: 'Stylist',   width: 0.175},
        {text: 'Customer',   width: 0.2},
        {text: 'Type',   width: 0.175},
        {text: 'Status',   width: 0.175},
        {text: 'Queue',   width: 0.175},
    ]  

    color: "#fef0f0"
    border.color: "#221919"
    Button {
        id: button
        x: 16
        y: 37
        width: 178
        height: 64
        text: qsTr("Show All Jobs")
        font.family: "Times New Roman"
        font.bold: true
        font.pointSize: 15
        palette {
            button: "#ffa07a"
        }
        onClicked: {
            Service.get_jobs(function(resp) {
            print('handle get jobs resp: ' + JSON.stringify(resp));
                var jobs=[];
                for(var i=0;i<resp.length;i++)
                {
                    var job=[]
                    job.push(resp[i]["ID"]);
                    job.push(resp[i]["Stylist"]);
                    job.push(resp[i]["Customer"]);
                    job.push(resp[i]["Type"]);
                    job.push(resp[i]["Status"]);
                    job.push(resp[i]["QNumber"]);
                    jobs.push(job);
                }
                print(jobs)
                table1.dataModel=jobs
                element1.visible=true
             });
        }
    }
    Button {
        id: button2
        x: 200
        y: 37
        width: 167
        height: 64
        text: qsTr("Show the job")
        font.family: "Times New Roman"
        font.bold: true
        font.pointSize: 15
        palette {
            button: "#ffa07a"
        }
        onClicked: {            
            var jobid=textInput.text;
            Service.get_job(jobid,function(resp) {
            print('handle get jobs resp: ' + JSON.stringify(resp));
            var jobs=[]
            var job=[]
            job.push(resp["ID"]);
            job.push(resp["Stylist"]);
            job.push(resp["Customer"]);
            job.push(resp["Type"]);
            job.push(resp["Status"]);
            job.push(resp["QNumber"]);
            print(job)
            jobs.push(job);
            element1.visible=false
            table2.dataModel=jobs
            element2.visible=true
            });
        }
    }
    Button {
        id: button3
        x: 383
        y: 37
        width: 192
        height: 64
        text: qsTr("Assign the job")
        font.family: "Times New Roman"
        font.bold: true
        font.pointSize: 15
        palette {
            button: "#ffa07a"
        }
        onClicked: {
            var jobid=textInput.text;
            Service.assign_job(jobid,function(resp) {
            print('handle get jobs resp: ' + JSON.stringify(resp));
            var jobs=[]
            var job=[]
            job.push(resp["ID"]);
            job.push(resp["Stylist"]);
            job.push(resp["Customer"]);
            job.push(resp["Type"]);
            job.push(resp["Status"]);
             job.push(resp["QNumber"]);
            print(job)
            jobs.push(job);
            element1.visible=false
            table2.dataModel=jobs
            element2.visible=true
            });
        }
    }
    Button {
        id: button4
        x: 676
        y: 398
        width: 107
        height: 57
        text: qsTr("Back")
        font.family: "Times New Roman"
        font.bold: true
        font.pointSize: 20
        palette {
            button: "#ffa07a"
        }
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
        x: 652
        y: 79
        width: 123
        height: 37
        color: "#e2fff0"
        border.color: "#0f0e0e"

        TextInput {
            id: textInput
            color: "#ee0d0d"
            anchors.fill:parent
            text: qsTr("1")
            anchors.rightMargin: -8
            anchors.leftMargin: 8
            anchors.topMargin: 15
            anchors.bottomMargin: 15
            font.bold: true
            font.family: "Times New Roman"
            font.pixelSize: 16
        }
    }
    NumberPad {
        id: numberPad
        y: 129
        width: 125
        height: 100
        anchors.horizontalCenterOffset: 258
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
        x: 652
        y: 45
        width: 123
        height: 20
        text: qsTr("Job Code")
        font.pointSize: 17
        font.bold: true
        font.family: "Times New Roman"
        horizontalAlignment: Text.AlignHCenter
    }
}
