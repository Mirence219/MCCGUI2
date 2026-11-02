import QtQuick
import QtQuick.Controls

ApplicationWindow {
	id: mainWindow
	title: "MCCGUI2"
	visible: true
	width: mccGuiScreen.width
	height: mccGuiScreen.height

	flags: Qt.Window | Qt.FramelessWindowHint
	
	MouseArea {
		width: mccGuiScreen.width
		height: mccGuiScreen.indexHeight
		onPressed: (mouse) => mainWindow.startSystemMove()
	}

	MGScreen {
		id: mccGuiScreen
	}
}