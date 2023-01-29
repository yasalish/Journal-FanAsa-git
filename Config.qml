import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import "HttpService.js" as Service
import FileIO 1.0


Page {
    id:root
    width: 800
    height: 480
    title: qsTr("Config")

    property string stylistName: ''

    FileIO {
        id: myFile
        source: "Configs.json"
        onError: console.log(msg)
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
            text: qsTr("Please Enter the server IP address:")
            font.family: "Times New Roman"
            font.bold: true
            anchors.verticalCenterOffset: -109
            anchors.horizontalCenterOffset: 23
            font.pointSize: 23
            anchors.centerIn: rectangle1
        }

        Rectangle {
            id: rectangle
            x: 269
            y: 215
            width: 317
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
                text: qsTr("192.168.1.7")
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
                text: qsTr("Submit")
                font.weight: Font.Bold
                font.pointSize: 15
                font.family: "Times New Roman"
                anchors.fill:rectangle2
                palette {
                       button: "#ffa07a"
                   }
                onClicked: {
                    print("***************")
                    print(ipAddress)
                    ipAddress=textInput.text;
                    print(ipAddress)
                    var ip_add="{\"IPAddr\": \""+ipAddress+"\"}";
                    print(ip_add);
                    myFile.write(ip_add)
                    stackView.push("Home.qml");
                }
            }
        }

        Button {
            id: button1
            x: 500
            y: 304
            width: 100
            height: 68
            text: qsTr("Back")
            font.bold: true
            font.pointSize: 15
            font.family: "Times New Roman"
            onClicked: {
                stackView.push("Home.qml");
            }
            palette {
                   button: "#ffa07a"
               }
        }
        Button {
            id: button2
            x: 372
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
        NumberPad {
            id: numberPad
            y: 185
            width: 125
            height: 100
            anchors.horizontalCenterOffset: -321
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
    }
    Dialog {
        id: dialog
                    title: qsTr("Warning")
                    Label {
                            text: "You are not authorized!"
                        }
        }
}
