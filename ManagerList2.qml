import QtQuick 2.12
import QtQuick.Controls 2.5
Rectangle {
    width: 800
    height: 480
    property
    var jobs:[
        {
            id: 0,
            customer: "Taraneh",
            stylist: "Maryam",
            type:"Haircut",
            finished:0
        },
        {
            id: 1,
            customer: "Zahra",
            stylist: "Maryam",
            type:"Haircut",
            finished:0
        },
        {
            id: 2,
            customer: "Zohreh",
            stylist: "Raha",
            type:"Coloring",
            finished:0
        },
        {
            id: 3,
            customer: "Taraneh",
            stylist: "Sara",
            type:"Makeup",
            finished:0
        },
        {
            id: 4,
            customer: "Fariba",
            stylist: "Raha",
            type:"Coloring",
            finished:0
        },
        {
            id: 5,
            customer: "Simin",
            stylist: "Sara",
            type:"Makeup",
            finished:0
        },
        {
            id: 6,
            customer: "Sima",
            stylist: "Maryam",
            type:"Haircut",
            finished:0
        },
        {
            id: 7,
            customer: "Hoda",
            stylist: "Sara",
            type:"Makeup",
            finished:0
        }
    ]
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
    function retJobs()
    {
        var jobList=[];
        for (var i = 0; i < jobs.length; i++) {
            var obj = jobs[i];
            if(obj.finished==0)
            {
                jobList.push(obj.type)
            }

        }
        return(jobList)
    }
    function retStylist()
    {
        var stylistList = [];
        for (var i = 0; i < jobs.length; i++) {
            var obj = jobs[i];
            if(obj.finished==0)
            {
                stylistList.push(obj.stylist)
            }
        }
        return(stylistList)
    }
    function retCustomers()
    {
        var num=0;
        var customerList = [];
        for (var i = 0; i < jobs.length; i++) {
            var obj = jobs[i];
            if(obj.finished==0)
            {
                customerList.push(obj.customer)
            }
        }
        return(customerList)

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
            element.text="Number of Jobs = "+ numJobs()+"<br><br><br>Job Types = "+retJobs()+"<br><br><br>Stylist Names = "+retStylist()+"<br><br><br>Customer Names = "+retCustomers()
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
            var i = textInput.text
            element.text=""
            if(i<jobs.length)
                  element.text="Job ID = "+i+"<br><br><br>Job Type = "+jobs[i].type+"<br><br><br>Stylist Name = "+jobs[i].stylist+"<br><br><br>Customer Name = "+jobs[i].customer
            else
                  element.text="---- > Undefined Job < -----"

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
            element.text=""
            element.text="Job ID = "+i+"<br><br><br>Job Type = "+jobs[i].type+"<br><br><br>Stylist Name = "+jobs[i].stylist+"<br><br><br>Customer Name = "+jobs[i].customer

        }
    }
    Button {
        id: button4
        x: 665
        y: 342
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
    Text {
        id: element
        x: 20
        y: 153
        width: 266
        height: 276
        color: "#1c5a2d"
        text: qsTr("")
        font.bold: true
        font.family: "Times New Roman"
        font.pixelSize: 16
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
        y: 127
        width: 125
        height: 100
        anchors.horizontalCenterOffset: 313
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
