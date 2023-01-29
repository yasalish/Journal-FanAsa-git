import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import SerialPort 1.0
import FileIO 1.0
import "MifareMethods.js" as Mifare
import "HttpService.js" as Service

Page {
    id:root
    width: 800
    height: 480
    property alias button2: button2
    title: qsTr("Login")

    signal onStylistCodeChanged()

    property string stylistName: ''
    property var stylistCode:""

    FileIO {
        id: myFile
        source: "Configs.json"
        onError: console.log(msg)
    }

    SerialPort{
            id: serial
            onDataReceived: {
                        rcount++
                        print("onDataReceived -> ",data,"\t",rcount,"\t",data.length)
                        rdata=data
                        switch(rcount)
                            {
                                case 1: Mifare.sendAntiCollisionCommnad();break;
                                case 2: Mifare.sendSelectCommand();break;
                                case 3: Mifare.sendAuthKeyB();break;
                                case 4: Mifare.readMifare();break;
                                case 5: stylistCode = Mifare.retStylistCode();
                                        print(stylistCode);
                                        break;
                             }
                    }
        }

    Rectangle {
        id: rectangle1
        x: 183
        y: 69
        width: 200
        height: 200
        color: "#f0f5d6"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill:parent
        Label {
            color: "#c71585"
            text: qsTr("کارت را مقابل کارت خوان بگیرید یا کد را وارد نمایید:")
            font.family: "B Roya"
            font.bold: true
            anchors.verticalCenterOffset: -113
            anchors.horizontalCenterOffset: -7
            font.pointSize: 22
            anchors.centerIn: rectangle1
        }
        Rectangle {
            id: rectangle
            x: 299
            y: 181
            width: 203
            height: 51
            color: "#fceded"
            radius: 0
            border.color: "#d40e0e"
            TextInput {
                id: textInput
                anchors.fill:rectangle
                x: 53
                y: 16
                width: 80
                height: 20
                color: "#f05c5c"
                text: qsTr("111")
                anchors.rightMargin: 0
                anchors.bottomMargin: -8
                anchors.leftMargin: 0
                anchors.topMargin: 8
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.Bold
                font.pixelSize: 28
            }
        }

        FButton {
                id: button
                bText: "ورود"
                y:304
                x:237
                onClicked: {
                    print(button.width)
                    var stylistid=textInput.text;
                    Service.login_stylist(stylistid,function(resp) {
                    print('handle get stylists resp: ' + JSON.stringify(resp));
                    var name = resp["Name"];
                    console.log(name);
                    if(name === 'Manager')
                    {
                            serial.close();
                            stackView.push("Manager.qml");
                    }
                    else if(name !== 'Unknown')
                        {
                            serial.close();
                            root.stylistName=name;
                            console.log(root.stylistName)
                            stackView.push("Stylist.qml",{stylistName : stylistName});
                        }
                    else
                        dialog.open()
                    });
                }
           }

        FButton {
           id: button1
            x: 665
            y: 304
            bText: "خروج"            
            onClicked: {
                Qt.quit()
            }
        }

        FButton {
            id: button2
            x: 363
            y: 304
            bText: "پاک کردن"
            onClicked: textInput.text=""

        }

        FButton {
            id: button3
            x: 521
            y: 304
            bText: "تنظیمات"
            onClicked: {
                stackView.push("Config.qml");
            }

        }

        NumberPad {
            id: numberPad
            y: 190
            width: 125
            height: 100
            anchors.horizontalCenterOffset: -319
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                    if(value>=0 && value<=9)
                    {
                          textInput.text += value;
                    }
                    else if(value==10)
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
    }
    Dialog {
        id: dialog
                    title: qsTr("Warning")
                    Label {
                            text: "You are not authorized!"
                        }
        }
    Component.onCompleted: {
        var msg=JSON.parse(myFile.read())
        print("IP Address = ",msg["IPAddr"])
        print("Serial = ",msg["Port"])
        var ip = msg["IPAddr"]
        ipAddress=ip
        serPort = msg["SerPort"]
        print("IP Address = ",ipAddress,"Serial Port = ",serPort)
        print("Component.onCompleted",serPort,"\t",ipAddress)
        serial.open(serPort)
        rcount=0
        rdata=""
        Mifare.sendReqACommnad();
                    }
    onStylistCodeChanged:
    {
        print("*******  onStylistCodeChanged    *************",stylistCode)
        var stylistid=stylistCode;
        Service.login_stylist(stylistid,function(resp) {
        print('handle get stylists resp: ' + JSON.stringify(resp));
        var name = resp["Name"];
        console.log(name);
        if(name === 'Manager')
        {
                serial.close();
                stackView.push("Manager.qml");

        }
        else if(name !== 'Unknown')
            {
                serial.close();
                root.stylistName=name;
                console.log(root.stylistName)
                stackView.push("Stylist.qml",{stylistName : stylistName});
            }
        else{
            dialog.open()
            rcount=0
            rdata=""
            Mifare.sendReqACommnad();
        }
        });
    }
}
