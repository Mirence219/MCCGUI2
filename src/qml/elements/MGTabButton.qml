import QtQuick
import QtQuick.Controls

TabButton {
	id: indexButton
	width: Math.max(80, buttonText.implicitWidth + 20)
	height: 30
	bold: checked
	autoExclusive: true
	checkable: true
	background: Rectangle {
		color: indexButton.checked || indexButton.pressed ? Qt.darker("#9696ff", 1.1) :(indexButton.hovered ? Qt.darker("#9696ff", 1.05): "transparent")
		radius: height / 2
	}
	text: "导航文本"

	property alias textColor: buttonText.color
	property alias fontSize: buttonText.fontSize
	property alias bold: buttonText.bold

	contentItem: MGText {
		id: buttonText
		text: indexButton.text
		anchors.centerIn: parent
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		color: indexButton.checked ? "white" : "black"
	}

	onClicked: {
		console.log("MGTabButton clicked!")
	}
}