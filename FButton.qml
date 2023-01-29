import QtQuick 2.0
import QtQuick.Controls 2.13

Item {
   id:root
    width: 75
    height: 80
    property string bText
    signal clicked

    Button {
               id: testButton
               width: root.width+(txt.width/2)+5
               height: root.height
               background: Rectangle {
                    color: "#000000"
                    Gradient {
                        id: normalGradient
                        GradientStop { position: 0.0; color: "#252525" }
                        GradientStop { position: 0.5; color: "#b0f1e6" }
                        GradientStop { position: 1.0; color: "#252525" }
                    }
                    Gradient {
                        id: hoveredGradient
                        GradientStop { position: 0.0; color: "#252525" }
                        GradientStop { position: 0.5; color: "#e0ffff" }
                        GradientStop { position: 1.0; color: "#252525" }
                    }
                    Gradient {
                        id: pressedGradient
                        GradientStop { position: 0.0; color: "#252525" }
                        GradientStop { position: 0.5; color: "#00875c" }
                        GradientStop { position: 1.0; color: "#252525" }
                    }

                    gradient: testButton.pressed ? pressedGradient :
                              testButton.hovered ? hoveredGradient :
                                                   normalGradient
                    radius: 10
                    border.width: 2.0
                    border.color: "#000000"
                }

                Text{
                        id: txt
                        text:bText
                        font.family: "B Roya"
                        font.pointSize: 20
                        font.bold: true
                        color: "#c71585"
                        anchors.centerIn: parent

                    }
                onClicked: root.clicked()
        }
}


