import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 480
    title: qsTr("FanAsa")
    StackView {
        id: stackView
        initialItem: "Home.qml"
        anchors.fill: parent
    }
}
