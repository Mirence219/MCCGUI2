import QtQuick
import QtQuick.Controls

Button {
	id: root

	width: btnText.implicitWidth + 20
	height: btnText.implicitHeight + 10

	property color primaryColor: "#ccccff"
	property color primaryHover: "#ada5fa"
	property color primaryPress: "#b096ff"
	property color borderColor: "#96b0ff"
	property color disabledColor: "lightgray"

	property alias bold: btnText.bold
	property alias fontSize: btnText.fontSize
	property color textColor: "#444444"
	property color textHoverColor: "#ffffff"

	padding: 0
	fontSize: 10

	background: Rectangle {
		radius: 6
		color: !root.enabled ? root.disabledColor : (
			root.pressed ? root.primaryPress : (
			root.hovered ? root.primaryHover : root.primaryColor))
	}

	contentItem: Item {
        anchors.fill: parent
        MGText {
            id: btnText
            text: root.text
            anchors.centerIn: parent
			color: (root.enabled && (root.hovered || root.pressed)) ? root.textHoverColor : root.textColor
			bold: (root.enabled && (root.hovered || root.pressed))
        }
    }

	onClicked: {
		console.log("Button clicked!")
	}
}
