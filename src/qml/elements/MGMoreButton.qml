import QtQuick
import QtQuick.Controls

Button {
	id: root
	width: 5
	height: 20

	background: null

	property alias fontSzie: btnText.font.pointSize
	property alias color: btnText.color

	contentItem: Item {
		anchors.fill: parent
		Text {
			id: btnText
			anchors.centerIn: parent
			text: "⋮"
			font.bold: true
			font.pointSize: 25
			color: root.hovered ? "#8e43fe" : "#9696ff"
		}
	}

	onClicked: {
		console.log("MoreBurron clicked!")
	}
}