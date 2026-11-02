import QtQuick
import QtQuick.Controls

TextField {
	id: inputLine
	placeholderText: "输入框文本"
	font.pointSize: 12

	background: Rectangle {
		radius:6
		border.color: inputLine.activeFocus ? "#b096ff":"#888899"
		border.width: inputLine.activeFocus ? 2 : 1
	}

}