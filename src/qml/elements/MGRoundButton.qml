import QtQuick
import QtQuick.Controls

Button {
	id: root
	property alias bold: buttonText.bold
	property alias textColor: buttonText.color
	property alias fontSize: buttonText.fontSize
	property int direct: 30
	
	width: direct
	height: direct
	text: "圆形按钮文本"

	background: Rectangle {
		anchors.fill: parent
		radius: root.direct / 2
		color: root.pressed ? "#6933ff" : (root.hovered ? "#b096ff": "#9696ff")
	}

	contentItem: 
		MGText {
			id: buttonText
			text: root.text
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
		}
}
