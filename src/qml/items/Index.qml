import QtQuick
import "../elements"

Rectangle {
	id: root
	width: parent.width
	height: 50
	color: "#9696ff"
	
	property string textColor: "white"
	property int textSize: 12
	property int itemSpace: 20
	property int itemPadding: 5
	property alias currentIndex: index.currentIndex

	MGText {
		text: "MCCGUI"
		font.bold: true
		x: 15
		color: "white"
		anchors.verticalCenter: parent.verticalCenter
	}

	Row {
		id: rootTool
		anchors.right: parent.right
		anchors.rightMargin: 15
		anchors.verticalCenter: parent.verticalCenter
		spacing: 10
			
		MGRoundButton {
			text: "-"
			font.bold: true
			textColor: "white"
			fontSize: 25
			onClicked: {
				mainWindow.visibility = Window.Minimized
				console.log("[INFO] 点击最小化")
			}
		}
		MGRoundButton {
			text: "×"
			font.bold: true
			textColor: "white"
			fontSize: 25
			onClicked: 
			{
				close()
				console.log("[INFO] 点击关闭窗口")
			}
		}
	}

	MGTabBar {
		id: index
		anchors.centerIn: parent

		MGTabButton {
			text: "仪表盘"
			checked: true
			textColor: root.textColor
			onClicked: 
			{
				index.currentIndex = 0;
				console.log("[INFO] 点击仪表盘");
			}
		}
		MGTabButton {
			text: "账户"
			textColor: root.textColor
			onClicked: 
			{
				index.currentIndex = 1;
				console.log("[INFO] 点击账户");
			}
		}
		MGTabButton {
			text: "下载"
			textColor: root.textColor
			onClicked: 
			{
				index.currentIndex = 2;
				console.log("[INFO] 点击下载");
			}
		}
		MGTabButton {
			text: "设置"
			textColor: root.textColor
			onClicked: 
			{
				index.currentIndex = 3;
				console.log("[INFO] 点击设置");
			}
		}
	}
}
