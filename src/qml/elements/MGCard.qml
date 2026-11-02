import QtQuick

Rectangle {
	id: card
	width: 200
	height: 100
	color: "#dde0e0ff"
	radius: 8

	MouseArea {
		id: mouse
		anchors.fill: parent
		hoverEnabled: true
	}
}