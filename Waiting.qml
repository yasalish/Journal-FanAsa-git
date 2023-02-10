import QtQuick 2.12
import QtQuick.Controls 2.5
import Qt.WebSockets 1.1
import "HttpService.js" as Service

Rectangle {
    property alias stylistName: label1.text
    property int getJob:0
    property var  header: [ // widths must add to 1
        {text: 'صف',     width: 0.1},
        {text: 'وضعیت',   width: 0.2},
        {text: 'خدمت',   width: 0.2},
        {text: 'مشتری',   width: 0.175},
        {text: 'آرایشگر',   width: 0.175},
        {text: 'شماره',   width: 0.15},
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
        x: 199
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
                job.push(resp["QNumber"]);
                job.push(resp["Status"]);
                job.push(resp["Type"]);
                job.push(resp["Customer"]);
                job.push(resp["Stylist"]);
                job.push(resp["ID"]);
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
            Service.get_stylist_name(stylistName,function(resp) {
            print('handle get stylists resp:**** ' + JSON.stringify(resp))
               if(resp["Status"]==="آماده")
                   stylistStatus.color="green"
            });
            button.visible=false;
            element.visible=true;
            busyIndicator.visible=true;
            print("getJob=",getJob)
            socket.active=true
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
        x: 297
        y: 331
        bText:"پذیرش کار"
        visible:false
        onClicked: {
            Service.accept_job(jobID,function(resp) {
            print('handle get jobs resp:---->1' + JSON.stringify(resp));
            element3.visible=false
            element4.visible=true
            button4.visible=true
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
            table2.dataModel=jobs
            element2.visible=true
            button2.visible=false
            stylistStatus.color="red"
            Service.get_stylist_name(stylistName,function(resp) {
                print('handle get stylists resp:****> 2 ' + JSON.stringify(resp))
                   if(resp["QPerson"]===0)
                       stylistQueue.color="green"
                   else
                       stylistQueue.color="red"
                });
           });

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
            x: 55
            y: 114
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
        id: stylistStatus
        x: 635
        y: 157
        width: 98
        height: 76
        color: "blue"
        radius: 32
    }

    Rectangle {
        id: stylistQueue
        x: 635
        y: 267
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
        y: 122
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
        y: 234
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
              {
                  stylistQueue.color="red"
                  stylistStatus.color="green"
              }
        });
        }

}
