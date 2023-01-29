import QtQuick 2.12
import QtQuick.Controls 2.5
import Qt.WebSockets 1.1
import "HttpService.js" as Service

Rectangle {
    property alias stylistName: label1.text
    property int getJob:0
    property var  header: [ // widths must add to 1
        {text: 'ID',     width: 0.1},
        {text: 'Stylist',   width: 0.225},
        {text: 'Customer',   width: 0.225},
        {text: 'Type',   width: 0.225},
        {text: 'Status',   width: 0.225},
    ]
    property int jobID:-1
    width: 800
    height: 480
    color: "#fef0f0"

    Timer {
        id: timer
    }

    function delay(delayTime, cb) {
        timer.interval = delayTime;
        if(getJob===0)
            timer.repeat = true;
        else
            timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }


    Label {
        id:label1
        color: "#4896e2"
        //text: "Hello "+"!"
        anchors.verticalCenterOffset: -127
        anchors.horizontalCenterOffset: horizontalCenter
        font.bold: true
        font.pointSize: 24
        font.family: "Times New Roman"
        anchors.centerIn: parent
        visible: false
    }

    Text {
        id: element
        x: 254
        y: 22
        color: "#0d6583"
        text: "در انتظار انجام کار!"
        font.bold: true
        font.pointSize: 28
        font.family: "B Roya"
        font.pixelSize: 36
        visible:false

    }
    Text {
        id: element3
        x: 232
        y: 48
        color: "#0d6583"
        text: "یک کار به شما اختصاص یافت!"
        font.bold: true
        font.pointSize: 28
        font.family: "B Roya"
        font.pixelSize: 36
        visible:false

    }
    Text {
        id: element4
        x: 304
        y: 48
        color: "#0d6583"
        text: "کار شروع شد!"
        font.bold: true
        font.pointSize: 28
        font.family: "B Roya"
        font.pixelSize: 36
        visible:false

    }
    Text {
        id:t1
        x: 27
        y: 81
        width: 308
        height: 336
        color: "#690a0a"
        styleColor: "#ee9595"
        font.family: "Times New Roman"
        font.pointSize: 14
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        WebSocket {
            id: socket
            url: bASEws
            active: true
            onTextMessageReceived: {
                getJob=1;
                element.visible=false;
                busyIndicator.visible=false;
                timer.repeat=false;
                print("--------------->",getJob)
                element3.visible=true;
                button2.visible=true
                var msg=message.replace(/\'/g, "\"");
                print(msg)
                var resp = JSON.parse(msg)
                print(resp["ID"]);
                var jobs=[]
                var job=[]
                jobID=resp["ID"];
                job.push(resp["ID"]);
                job.push(resp["Stylist"]);
                job.push(resp["Customer"]);
                job.push(resp["Type"]);
                job.push(resp["Status"]);
                print(job)
                print(jobID)
                jobs.push(job);
                table2.dataModel=jobs
                element2.visible=true
            }
            onStatusChanged: {
            if (socket.status == WebSocket.Error) {
            console.log("Error: " + socket.errorString)
            } else if (socket.status == WebSocket.Open) {
                socket.sendTextMessage(stylistName)
            } else if (socket.status == WebSocket.Closed) {
                t1.text += "\nSocket closed"
            }
            }
        }
    }
    BusyIndicator {
        id: busyIndicator
        x: 273
        y: 179
        width: 255
        height: 158
        visible:false
    }
    FButton {
        id: button
        x: 214
        y: 121
        width:150
        bText:"آماده برای پذیرش کار"
        onClicked: {
            button.visible=false;
            element.visible=true;
            busyIndicator.visible=true;
            print("getJob=",getJob)
            delay(2000, function() {
                print("And I'm printed after 1 second!***", getJob)
                socket.sendTextMessage(stylistName)                
            })
        }
    }
    FButton {
        id: button4
        x: 331
        y: 343
        bText:"پایان کار"
        visible:false
        onClicked: {
            print("Leaving Waiting Page .....")
            print(socket.destroy())
            Service.finish_job(jobID,function(resp) {
            print('handle get jobs resp: ' + JSON.stringify(resp));
            stackView.push("Stylist.qml",{stylistName : stylistName});
            });

        }
    }
    FButton {
        id: button2
        x: 331
        y: 330
        bText:"پذیرش کار"
        visible:false
        onClicked: {
            Service.accept_job(jobID,function(resp) {
            print('handle get jobs resp: ' + JSON.stringify(resp));
            element3.visible=false
            element4.visible=true
            button4.visible=true
            var jobs=[]
            var job=[]
            job.push(resp["ID"]);
            job.push(resp["Stylist"]);
            job.push(resp["Customer"]);
            job.push(resp["Type"]);
            job.push(resp["Status"]);
            print(job)
            jobs.push(job);
            table2.dataModel=jobs
            element2.visible=true
            button2.visible=false
            });
           // stackView.push("Stylist.qml",{stylistName : stylistName});
        }
    }
    FButton {
        id: button3
        x: 653
        y: 379
        bText:"بازگشت"
        onClicked: {
            print("Leaving Waiting Page .....")
            print(socket.destroy())
            stackView.push("Stylist.qml",{stylistName : stylistName});
        }
    }
    Rectangle {
            id: element2
            x: 121
            y: 110
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

}
