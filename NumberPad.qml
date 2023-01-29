import QtQuick 2.12
import QtQuick.Controls 2.5

Item {

    id: root
    signal clicked(int value)

    Column {
        id: col
        Grid {
            id: grid
            spacing: 5
            rows: 4
            columns: 3
        }
    }

    function doClicked(value) {
        console.log(value)
        clicked(value)
    }

    Component.onCompleted: {
        console.log("Creating Button")
        var num = 0
        for(var i = 0; i < 10; i++){

            if(i === 0) num = 7; //First Row
            if(i === 3) num = 4; //Second Row
            if(i === 6) num = 1; //Third Row
            if(i === 9) num = 0; //Bottom Row
            var btn = Qt.createQmlObject('import QtQuick 2.0; import QtQuick.Controls 2.3; \
                        RoundButton {id: btn' + i +';onClicked:doClicked('+ num +');\
                         background: Rectangle {radius: parent.radius;color: "#b0e0e6"}\
                         }',grid,"DynamicallyLoaded")
            btn.text = num
            btn.width = 65
            btn.height = 65
            btn.font.pixelSize=17
            btn.font.bold=true
            num++
        }
        num=10
        btn = Qt.createQmlObject('import QtQuick 2.0; import QtQuick.Controls 2.3; \
                    RoundButton {id: btn' + i +';onClicked:doClicked('+ num +');\
                     background: Rectangle {radius: parent.radius;color: "#b0e0e6"}\
                     }',grid,"DynamicallyLoaded")
        btn.text ='.'
        btn.width = 65
        btn.height = 65
        btn.font.pixelSize=17
        btn.font.bold=true
        //var obj = grid.children[grid.children.length - 1]
        num=11
        btn = Qt.createQmlObject('import QtQuick 2.0; import QtQuick.Controls 2.3; \
                    RoundButton {id: btn' + i +';onClicked:doClicked('+ num +');\
                     background: Rectangle {radius: parent.radius;color: "#b0e0e6"}\
                     }',grid,"DynamicallyLoaded")
        btn.text = "\u232b"
        btn.width = 65
        btn.height = 65
        btn.font.pixelSize=17
        btn.font.bold=true
    }


}
