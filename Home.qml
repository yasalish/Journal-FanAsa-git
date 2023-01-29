import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import SerialPort 1.0
import "MifareMethods.js" as Mifare
import "HttpService.js" as Service

Page {
    id:root
    width: 800
    height: 480
    title: qsTr("Login")

    signal onStylistCodeChanged()

    property string stylistName: ''
    property var stylistCode:""

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
        anchors.fill:parent
        Label {
            color: "#4b8bca"
            text: qsTr("Please Enter your code")
            font.family: "Times New Roman"
            font.bold: true
            anchors.verticalCenterOffset: -82
            anchors.horizontalCenterOffset: -11
            font.pointSize: 20
            anchors.centerIn: rectangle1
        }

        Rectangle {
            id: rectangle
            x: 299
            y: 215
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
        Rectangle {
            id: rectangle2
            x: 255
            y: 304
            width: 98
            height: 68
            color: "#b8d7b5"

            Button {
                id: button
                text: qsTr("Login")
                font.weight: Font.Bold
                font.pointSize: 15
                font.family: "Times New Roman"
                anchors.fill:rectangle2
                palette {
                       button: "#ffa07a"
                   }
                onClicked: {
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
        }

        Button {
            id: button1
            x: 650
            y: 304
            width: 100
            height: 68
            text: qsTr("Exit")
            font.bold: true
            font.pointSize: 15
            font.family: "Times New Roman"
            onClicked: Qt.quit()
            palette {
                   button: "#ffa07a"
               }
        }
        Button {
            id: button2
            x: 382
            y: 304
            width: 100
            height: 68
            text: qsTr("Clear")
            font.bold: true
            font.pointSize: 15
            font.family: "Times New Roman"
            palette {
                   button: "#ffa07a"
               }
            onClicked: textInput.text=""

        }
        Button {
            id: button3
            x: 520
            y: 304
            width: 100
            height: 68
            text: qsTr("Config")
            font.bold: true
            font.pointSize: 15
            font.family: "Times New Roman"
            palette {
                   button: "#ffa07a"
               }
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
        Image{
            x: 544
            y: 0
            width: 256
            height: 120
            source:"logo.png"
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
            serial.open()
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
