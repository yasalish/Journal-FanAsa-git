import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: 800
    height: 480
    title: qsTr("Login")

    property
      var myData: [{
          id: 1,
          name: "Manager",
          code: 111
        },
        {
          id: 2,
          name: "Maryam",
          family: 112
        },
        {
          id: 3,
          name: "Sara",
          family: 113
        },
        {
          id: 4,
          name: "Raha",
          family: 114
        }
      ]


    Rectangle {
        id: rectangle1
        x: 183
        y: 69
        width: 200
        height: 200
        color: "#f0f5d6"
        anchors.fill:parent
        Label {
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
                text: qsTr("111")
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.Bold
                font.pixelSize: 22
            }
        }

        Rectangle {
            id: rectangle2
            x: 340
            y: 282
            width: 98
            height: 68
            color: "#ffffff"

            Button {
                id: button
                text: qsTr("Login")
                font.weight: Font.Bold
                font.pointSize: 15
                font.family: "Times New Roman"
                anchors.fill:rectangle2
            }
        }


    }
}
