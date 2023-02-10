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
    signal onCardUIDChanged()

    property string stylistName: ''
    property var stylistCode:""
    property var counter:0
    property var savedUID:0
    property var cardUID:""

    Timer {
           id: timer
       }

    function delay(delayTime, cb) {
           timer.interval = delayTime;
           timer.repeat = false;
           timer.triggered.connect(cb);
           timer.start();
       }


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
                        if(rcount==2 && data.length===18)
                         {
                             cardUID=data.substr(8,8)
                             print("----UID------",cardUID)
                        }
                        rdata=data                       
                        if(rcount==0 && counter==1)
                               {
                                   var test=0
                                   print("$$$$$$$$$$$$$ Hello $$$$$$$$$$$$$$$$$")
                                   delay(500, function(){
                                          test++;
                                          print("And I'm printed after 1 second!***",test,"\t",savedUID)
                                          if(test===1)
                                              Mifare.sendReqACommnad();
                                          rcount=0
                                           rdata=""
                                            })
                               }

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
        color: "#fef0f0"
        border.color: "#221919"
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
            color: "#f4e9e9"
            radius: 10
            border.color: "#e6dede"
            TextInput {
                id: textInput
                anchors.fill:rectangle
                x: 53
                y: 16
                width: 80
                height: 20
                color: "#a60dd4"
                text: qsTr("111")
                font.family: "B Roya"
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.Bold
                font.pixelSize: 34
            }
        }
        FButton {
                id: button
                bText: "ورود"
                y:304
                x:666
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
            x: 233
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
    Component.onCompleted: {
        var msg=JSON.parse(myFile.read())
        print("IP Address = ",msg["IPAddr"])
        print("Serial = ",msg["Port"])
        var ip = msg["IPAddr"]
        ipAddress=ip
        serPort = msg["SerPort"]
        print("IP Address = ",ipAddress,"Serial Port = ",serPort)
        print("Component.onCompleted",serPort,"\t",ipAddress)
        serial.close()
        serial.open(serPort)
        rcount=0
        rdata=""
        Mifare.sendReqACommnad();
                    }
    /*
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
            counter++;
            if(counter==2)
                {
                  if(savedUID===stylistCode)
                      {
                         serial.close();
                         stackView.push("Manager.qml");
                      }
                  else
                      {
                          print("Another Card @@@@@@@@@@@@@@")
                          counter=1
                      }
               }
            if(counter==1)
                     {
                           print("counter=1 @@@@@@@@@@@@@@")
                           savedUID=stylistCode;
                           rcount=-1
                           rdata=""
                           Mifare.sendRFOff()
                      }

        }
        else if(name !== 'Unknown')
            {
            counter++;
            if(counter==2)
                 {
                      if(savedUID===stylistCode)
                         {
                           serial.close();
                           console.log(root.stylistName)
                           stackView.push("Stylist.qml",{stylistName : stylistName});
                         }
                       else
                        {
                          print("Another Card @@@@@@@@@@@@@@")
                          counter=1
                        }
                  }
                  if(counter==1)
                        {
                            print("counter=1 @@@@@@@@@@@@@@")
                            savedUID=stylistCode;
                            rcount=-1
                            rdata=""
                            Mifare.sendRFOff()
                            timer.repeat=false
                            timer.stop()
                        }
            }
        else{
            dialog.open()
            rcount=0
            rdata=""
            Mifare.sendReqACommnad();
        }
        });
    }
    */
    onCardUIDChanged:
    {
        print("*******      onCardUIDChanged    *************",cardUID)
        var uid=cardUID;
        Service.login_stylist_card(uid,function(resp) {
        print('handle get stylists resp: ' + JSON.stringify(resp));
        var name = resp["Name"];
        console.log(name);
        if(name === 'Manager')
        {
            counter++;
            if(counter==2)
                {
                  if(savedUID===cardUID)
                      {
                         print("counter=2 @@@@@@@@@@@@@@")
                         serial.close();
                         stackView.push("Manager.qml");
                      }
                  else
                      {
                          print("Another Card @@@@@@@@@@@@@@")
                          counter=1
                      }
               }
            if(counter==1)
                     {
                           print("counter=1 @@@@@@@@@@@@@@")
                           savedUID=cardUID;
                           rcount=-1
                           rdata=""
                           Mifare.sendRFOff()
                      }

        }
        else if(name !== 'Unknown')
            {
            counter++;
            if(counter==2)
                 {
                      if(savedUID===cardUID)
                         {
                          print("counter=2 @@@@@@@@@@@@@@")
                          root.stylistName=name;
                           serial.close();
                           console.log(root.stylistName)
                           stackView.push("Stylist.qml",{stylistName : stylistName});
                         }
                       else
                        {
                          print("Another Card @@@@@@@@@@@@@@")
                          counter=1
                        }
                  }
                  if(counter==1)
                        {
                            print("counter=1 @@@@@@@@@@@@@@")
                            savedUID=cardUID;
                            rcount=-1
                            rdata=""
                            Mifare.sendRFOff()
                            timer.repeat=false
                            timer.stop()
                        }
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
