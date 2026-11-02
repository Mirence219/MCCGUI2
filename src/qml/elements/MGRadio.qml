import QtQuick
import QtQuick.Controls

RadioButton {
    id: radio
    checked: false
    spacing: 10

    //指示器
    indicator: Rectangle {
        implicitWidth: 24
        implicitHeight: 24
        radius: 12
        border.width: 2
        border.color: radio.hovered || radio.activeFocus ? "#b096ff" : "#888899"
        color: "transparent"
        anchors.verticalCenter: parent.verticalCenter

        //内部
        Rectangle {
            anchors.centerIn: parent
            width: 12
            height:12
            radius:6
            color: "#b096ff"
            visible: radio.checked
        }
    }

    //文字
    contentItem: MGText {
        id: radioText
        text: radio.text
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: indicator.right
        anchors.leftMargin: radio.spacing
        anchors.right: parent.right
        //elide: Text.ElideRight
    }
}
