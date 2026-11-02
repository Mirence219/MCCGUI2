import QtQuick
import QtQuick.Controls

CheckBox {
	id: checkBox
    checked: false
    spacing: 10

    //指示器
    indicator: Rectangle {
        implicitWidth: 24
        implicitHeight: 24
        radius: 2
        border.width: 2
        border.color: checkBox.hovered || checkBox.activeFocus ? "#b096ff" : "#888899"
        color: "transparent"
        anchors.verticalCenter: parent.verticalCenter

        //内部
        Rectangle {
            anchors.centerIn: parent
            width: 12
            height:12
            radius:1
            color: "#b096ff"
            visible: checkBox.checked
        }
    }

    //文字自定义
    contentItem: MGText {
        id: checkBoxText
        text: checkBox.text
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: indicator.right
        anchors.leftMargin: checkBox.spacing
        anchors.right: parent.right
        //elide: Text.ElideRight
    }
}