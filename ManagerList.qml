import QtQuick 2.12
import QtQuick.Controls 2.5
Rectangle {
    width: 800
    height: 480
    property var  header: [ // widths must add to 1
        {text: 'ID',     width: 0.1},
        {text: 'Type',   width: 0.225},
        {text: 'Stylist',   width: 0.225},
        {text: 'Customer',   width: 0.225},
        {text: 'Finished',   width: 0.225},
    ]
    property var jobs:[
        [0, 'Haircut','Maryam','Sahar',0],
        [1, 'Coloring','Simin','Sahar',0],
        [2, 'Makeup','Raha','Zahra',0],
        [3, 'Nail','Sara','Hoda',0],
        [4, 'Coloring','Simin','Parvaneh',0],
        [5, 'Haircut','Maryam','Ziba',0],
        [6, 'Makeup','Raha','Zohreh',0],
        [7, 'Haircut','Maryam','Arghavan',0],
        [8, 'Coloring','Simin','Azam',0],
        [9, 'Makeup','Raha','Nazi',1],
        [10, 'Haircut','Maryam','Maral',1],
    ]
    property var job:[[1, 'haircut','Maryam','Sahar',0]]
    function numJobs()
    {
        var num=0
        for (var i = 0; i < jobs.length; i++) {
            var obj = jobs[i];
            if(obj.finished==0)
            {
                num++;
            }

        }
        return(num);
    }

    color: "#fef0f0"
    border.color: "#221919"
    Button {
        id: button
        x: 16
        y: 37
        width: 192
        height: 64
        text: qsTr("Show list of all jobs")
        font.family: "Times New Roman"
        font.bold: true
        font.pointSize: 15
        palette {
            button: "#ffa07a"
        }
        onClicked: {
                   element1.visible=true
        }
    }
    Button {
        id: button2
        x: 240
        y: 37
        width: 132
        height: 64
        text: qsTr("Show the job")
        font.family: "Times New Roman"
        font.bold: true
        font.pointSize: 15
        palette {
            button: "#ffa07a"
        }
        onClicked: {
            element1.visible=false
            var i = textInput.text
            job=[jobs[i]]
            console.log(job)
            element2.visible=true
        }
    }
    Button {
        id: button3
        x: 408
        y: 37
        width: 139
        height: 64
        text: qsTr("Assign the job")
        font.family: "Times New Roman"
        font.bold: true
        font.pointSize: 15
        palette {
            button: "#ffa07a"
        }
        onClicked: {
            var i = textInput.text
        }
    }
    Button {
        id: button4
        x: 668
        y: 391
        width: 115
        height: 64
        text: qsTr("Back")
        font.family: "Times New Roman"
        font.bold: true
        font.pointSize: 20
        palette {
            button: "#ffa07a"
        }
        onClicked: {
            stackView.push("Manager.qml");
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
            anchors.fill: parent
            headerModel: header
            dataModel: jobs
            onClicked: {
                         print('onClicked', row, JSON.stringify(rowData))                         
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
            anchors.fill: parent
            headerModel: header
            dataModel:job
            onClicked: print('onClicked', row, JSON.stringify(rowData))
        }
    }
    Rectangle {
        id: rectangle
        x: 652
        y: 79
        width: 123
        height: 37
        color: "#e2fff0"
        border.color: "#0f0e0e"

        TextInput {
            id: textInput
            color: "#ee0d0d"
            anchors.fill:parent
            text: qsTr("1")
            anchors.rightMargin: -8
            anchors.leftMargin: 8
            anchors.topMargin: 15
            anchors.bottomMargin: 15
            font.bold: true
            font.family: "Times New Roman"
            font.pixelSize: 16
        }
    }
    NumberPad {
        id: numberPad
        y: 129
        width: 125
        height: 100
        anchors.horizontalCenterOffset: 258
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

    Label {
        id: label
        x: 652
        y: 45
        width: 123
        height: 20
        text: qsTr("Job code")
        font.pointSize: 17
        font.bold: true
        font.family: "Times New Roman"
        horizontalAlignment: Text.AlignHCenter
    }
}
