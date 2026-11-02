import QtQuick

Text {
	id: text
	property int fontSize: 13
	property string fontFamily: "Microsoft YaHei"
	property bool bold: false
	
	font.family: fontFamily
	text: "普通文本"
	font.pointSize: fontSize
	font.bold: bold
}