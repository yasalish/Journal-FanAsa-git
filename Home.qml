import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2

Page {
    id:root
    width: 800
    height: 480
    title: qsTr("Login")

    property string stylistName: ''

    property
      var myData: [{
          id: 1,
          name: "Manager",
          code: 111
        },
        {
          id: 2,
          name: "Maryam",
          code: 112
        },
        {
          id: 3,
          name: "Sara",
          code: 113
        },
        {
          id: 4,
          name: "Raha",
          code: 114
        },
        {
          id: 5,
          name: "Simin",
          code: 115
        }
      ]
    function retName(code)
    {
        for (var i = 0; i < myData.length; i++) {
              var obj = myData[i];
              if(obj.code == code)
              {
                  return(obj.name)
              }
        }
        return("unknown")
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
                        console.log("MyData : " + JSON.stringify(myData))
                        var name = retName(textInput.text)
                        console.log(name)

                        if(name=='Manager')
                            stackView.push("Manager.qml");
                        else if(name!='unknown')
                        {
                            root.stylistName="Hello "+name+"!"
                            console.log(root.stylistName)
                            stackView.push("Stylist.qml",{stylistName : stylistName});
                        }
                        else
                            dialog.open()


                }
            }
        }

        Button {
            id: button1
            x: 500
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
            y: 215
            width: 125
            height: 100
            anchors.horizontalCenterOffset: -297
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                    if(value>=0 && value<=9)
                    {
                          textInput.text += value;
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
}
