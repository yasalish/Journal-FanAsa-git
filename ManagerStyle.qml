import QtQuick 2.12
import QtQuick.Controls 2.5
import "HttpService.js" as Service
import SerialPort 1.0
import "MifareMethods.js" as Mifare

Rectangle {
    width: 800
    height: 480

    signal onStylistCardUIDChanged()
    property string stylistName: ''
    property string stylistCardUID: ''

/*
    property var  header1: [ // widths must add to 1
        {text: 'Code',     width: 0.15},
        {text: 'Name',      width: 0.225},
        {text: 'IP Address', width: 0.25},
        {text: 'Status',   width: 0.2},
        {text: 'Queue',   width: 0.175},
    ]
*/
    property var  header1: [ // widths must add to 1
        {text: 'صف',     width: 0.15},
        {text: 'وضعیت',      width: 0.225},
        {text: 'آدرس آی پی', width: 0.25},
        {text: 'نام',   width: 0.2},
        {text: 'شماره',   width: 0.175},
    ]
/*
    property var  header2: [ // widths must add to 1
        {text: 'ID',     width: 0.1},
        {text: 'Stylist',   width: 0.175},
        {text: 'Customer',   width: 0.2},
        {text: 'Type',   width: 0.175},
        {text: 'Status',   width: 0.175},
        {text: 'Queue',   width: 0.175},
    ]
*/
    property var  header2: [ // widths must add to 1
        {text: 'صف',     width: 0.1},
        {text: 'وضعیت',   width: 0.2},
        {text: 'خدمت',   width: 0.2},
        {text: 'مشتری',   width: 0.175},
        {text: 'آرایشگر',   width: 0.175},
        {text: 'شماره',   width: 0.15},
    ]

    property var stylistCode:""

    SerialPort{
            id: serial
            onDataReceived: {
                        rcount++
                        print("onDataReceived -> ",data,"\t",rcount,"\t",data.length)
                        rdata=data
                        if(rcount==2 && data.length===18)
                         {
                             stylistCardUID=data.substr(8,8)
                             print("----UID------",stylistCardUID)
                        }
                        switch(rcount)
                            {
                                case 1: Mifare.sendAntiCollisionCommnad();break;
                                case 2: Mifare.sendSelectCommand();break;
                                case 3: Mifare.sendAuthKeyB();break;
                                case 4: Mifare.readMifare();break;
                                case 5: Mifare.writeMifare(stylistCode);break;
                                case 6:
                                    if(Mifare.confirmWriteCode())
                                    {
                                        serial.close();
                                        dialog.open()
                                    }
                                    break;
                             }
                    }
        }
    color: "#fef0f0"
    border.color: "#221919"
    FButton {
        id: button
        x: 427
        y: 37
        bText: "آرایشگران"
        onClicked: {
            button5.visible=false
            Service.get_stylists(function(resp) {
            print('handle get stylists resp: ' + JSON.stringify(resp));
                var stylists=[];
                for(var i=0;i<resp.length;i++)
                {
                    var stylist=[]
                    /*
                    stylist.push(resp[i]["StylistID"]);
                    stylist.push(resp[i]["Name"]);
                    stylist.push(resp[i]["IPAddr"]);
                    stylist.push(resp[i]["Status"]);
                    stylist.push(resp[i]["QPerson"]);
                    */
                    if(resp[i]["Name"]!=='Manager')
                    {
                        stylist.push(resp[i]["QPerson"]);
                        stylist.push(resp[i]["Status"]);
                        stylist.push(resp[i]["IPAddr"]);
                        stylist.push(resp[i]["Name"]);
                        stylist.push(resp[i]["StylistID"]);
                        stylists.push(stylist);
                    }
                }
                print(stylists)
                table1.headerModel=header1
                table1.dataModel=stylists
                element1.visible=true
             });
        }
    }
    FButton {
        id: button2
        x: 253
        y: 37
        bText: "آرایشگر"
        onClicked: {
            var stylistid=textInput.text
            stylistCode=stylistid
            print("stylist_code--?",stylistCode)
            Service.get_stylist(stylistid,function(resp) {
            print('handle get stylists resp: ' + JSON.stringify(resp))
                var stylists=[]
                var stylist=[]
                /*
                stylist.push(resp["StylistID"]);
                stylist.push(resp["Name"]);
                stylist.push(resp["IPAddr"]);
                stylist.push(resp["Status"]);
                stylist.push(resp["QPerson"]);
                */

                stylist.push(resp["QPerson"]);
                stylist.push(resp["Status"]);
                stylist.push(resp["IPAddr"]);
                stylist.push(resp["Name"]);
                stylist.push(resp["StylistID"]);
                stylists.push(stylist);


                element1.visible=false
                table2.headerModel=header1
                table2.dataModel=stylists
                element2.visible=true
                button5.visible=true
            });
        }
    }
    FButton {
        id: button3
        x: 16
        y: 37
        width:110
        bText: "کارهای آرایشگر"
        onClicked: {
            button5.visible=false
            var stylistid=textInput.text;
            Service.get_stylist_jobs(stylistid,function(resp) {
            print('handle get stylists resp: ' + JSON.stringify(resp));
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
                element1.visible=false
                element2.visible=false
                table1.dataModel=jobs
                table1.headerModel=header2
                element1.visible=true
            });
        }
    }

    FButton {
        id: button4
        x: 643
        y: 392
        bText: "بازگشت"
        onClicked: {
            serial.close()
            stackView.push("ManagerList.qml");
        }
    }
    FButton {
        id: button5
        x: 140
        y: 367
        width:120
        bText: "ثبت کارت آرایشگر"
        visible: false
        onClicked: {
            serial.open(serPort)
            rcount=0
            rdata=""            
            Mifare.sendReqACommnad();            
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
            onClicked: {
                         print('onClicked', row, JSON.stringify(rowData))
                        stylistName=rowData[3]
                        stackView.push("Stylist.qml",{stylistName : stylistName});
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
                onClicked: {
                    print('onClicked', row, JSON.stringify(rowData))
                    stylistName=rowData[3]
                    stackView.push("Stylist.qml",{stylistName : stylistName});
                }
            }
        }
    Rectangle {
        id: rectangle
        x: 587
        y: 64
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
        y: 112
        width: 125
        height: 100
        anchors.horizontalCenterOffset: 250
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
        x: 587
        y: 31
        width: 123
        height: 20
        text: qsTr("کد آرایشگر")
        font.pointSize: 17
        font.bold: true
        font.family: "B Roya"
        horizontalAlignment: Text.AlignHCenter
    }
    Dialog {
        id: dialog
                    title: qsTr("FanAsa")
                    Label {
                            text: "ثبت نام موفقیت آمیز بود"
                            font.family: "B Roya"
                        }
                    modal: true
                    standardButtons: Dialog.Ok
                    x: (parent.width - width) / 2
                    y: (parent.height - height) / 2
        }

    onStylistCardUIDChanged:
    {
        var stylistid=textInput.text
        var entry =stylistCardUID
        Service.register_stylist(stylistid,entry,function(resp) {
        print('handle get stylists resp: ' + JSON.stringify(resp));
        });

    }
}
