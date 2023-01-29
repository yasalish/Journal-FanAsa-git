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
    property int activeInput

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
            color: "#c71585"
            text: qsTr("آدرس آی پی سرور سالن:")
            font.family: "B Roya"
            font.bold: true
            anchors.verticalCenterOffset: -158
            anchors.horizontalCenterOffset: 193
            font.pointSize: 25
            anchors.centerIn: rectangle1
        }

        Rectangle {
            id: rectangle
            x: 120
            y: 56
            width: 317
            height: 51
            color: "#fceded"
            radius: 0
            border.color: "#d40e0e"

            TextInput {
                id: textInput
                anchors.fill:rectangle                
                width: parent.width
                height: parent.height
                color: "#f05c5c"
                text: qsTr("192.168.1.7")                
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.Bold
                font.pixelSize: 28
                onActiveFocusChanged: {
                if (activeFocus) {
                                print("-----> Hello Text1")
                                activeInput=1
                                 }
                }
            }
        }
        Label {
            color: "#c71585"
            text: qsTr("شماره پورت سریال:")
            font.family: "B Roya"
            font.bold: true
            anchors.verticalCenterOffset: -85
            anchors.horizontalCenterOffset: 226
            font.pointSize: 25
            anchors.centerIn: rectangle1
        }

        Rectangle {
            id: rectangle2
            x: 323
            y: 131
            width: 114
            height: 51
            color: "#fceded"
            radius: 0
            border.color: "#d40e0e"
            TextInput {
                id: textInput2
                x: 0
                y: 8
                anchors.fill:rectangle
                width: parent.width
                height: parent.height
                color: "#f05c5c"
                text: qsTr("3")
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.Bold
                font.pixelSize: 28
                onActiveFocusChanged: {
                if (activeFocus) {
                        print("-----> Hello Text2")
                        activeInput=2
                                 }
                }
            }
        }

         FButton {
                id: button
                x: 256
                y: 298
                bText: "تایید"
                onClicked: {
                    print(ipAddress)
                    ipAddress=textInput.text;
                    serPort="ttyS"+textInput2.text
                    print(ipAddress,"\t",serPort)
var fileData="{\"IPAddr\": \""+ipAddress+"\", \"SerPort\": \""+serPort+"\"}";
                    print(fileData);
                    myFile.write(fileData)
                    stackView.push("Home.qml");
                }
            }

        FButton {
            id: button1
            x: 609
            y: 298
            bText: "بازگشت"
            onClicked: {
                stackView.push("Home.qml");
            }
         }
        FButton {
            id: button2
            x: 420
            y: 298
            bText: "پاک کردن"
            onClicked: textInput.text=""

        }
        NumberPad {
            id: numberPad
            y: 158
            width: 125
            height: 100
            anchors.horizontalCenterOffset: -318
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                    if(value>=0 && value<=9)
                    {
                        print("^^^",activeInput)
                        if(activeInput==1)
                                textInput.text += value;
                         else if(activeInput==2)
                                textInput2.text += value;
                    }
                    else if(value==10)
                    {
                        if(activeInput==1)
                              textInput.text += ".";
                    }
                    else
                    {
                        var st1 = ''
                        var st2 = ''
                        for(var i=0;i<textInput.length-1;i++)
                            st1 += textInput.text[i]
                        for(i=0;i<textInput2.length-1;i++)
                            st2 += textInput2.text[i]
                        if(activeInput==1)
                              textInput.text = st1;
                        else if(activeInput==2)
                              textInput2.text = st2;
                        console.log(st1)
                        console.log(st2)
                    }
            }
        }
    }   

}
