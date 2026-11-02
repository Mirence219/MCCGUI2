import QtQuick
import QtQuick.Controls

MenuItem {
	id: root
	text: "Menu Item"
	width: parent.width
	height: 30

	property color primaryColor: "#ada5fa"
	property color primaryHover: "#ada5fa"
	property color primaryPress: "#b096ff"
	property color borderColor: "#96b0ff"

	property alias bold: menuText.bold
	property alias fontSize: menuText.fontSize
	property color textColor: "#444444"
	property color textHoverColor: "#ffffff"

	background: Rectangle {
		anchors.fill: parent
		color: root.pressed ? root.primaryPress : (root.hovered ? root.primaryHover : "transparent")
		radius: 5
	}

	contentItem: Item {
		anchors.fill: parent
		MGText {
			id:menuText
			anchors.verticalCenter: parent.verticalCenter
			leftPadding: 5
			text: root.text
			fontSize: 11
			color: (root.hovered || root.pressed) ? root.textHoverColor : root.textColor
			bold: root.hovered || root.pressed
		}
	}

	onClicked: {
		console.log("Menu Button Clicked")
	}
}