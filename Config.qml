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
        color: "#fef0f0"
        border.color: "#221919"
        anchors.fill:parent
        Label {
            color: "#c71585"
            text: qsTr("آدرس آی پی سرور :")
            font.family: "B Roya"
            font.bold: true
            anchors.verticalCenterOffset: -156
            anchors.horizontalCenterOffset: 220
            font.pointSize: 25
            anchors.centerIn: rectangle1
        }

        Rectangle {
            id: rectangle
            x: 120
            y: 60
            width: 317
            height: 51
            color: "#f4e9e9"
            radius: 10
            border.color: "#e6dede"
            TextInput {
                id: textInput
                anchors.fill:rectangle                
                width: parent.width
                height: parent.height
                color: "#a60dd4"
                text: qsTr("192.168.1.7")
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                font.family: "B Roya"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.Bold
                font.pixelSize: 34
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
            color: "#f4e9e9"
            radius: 10
            border.color: "#e6dede"
            TextInput {
                id: textInput2
                x: 0
                y: 0
                anchors.fill:rectangle
                width: parent.width
                height: parent.height
                color: "#a60dd4"
                text: qsTr("3")
                font.family: "B Roya"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.Bold
                font.pixelSize: 34
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
            onClicked:{
                if(activeInput==1)
                        textInput.text = "";
                 else if(activeInput==2)
                        textInput2.text = "";
            }

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
                    else if(value==11)
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
