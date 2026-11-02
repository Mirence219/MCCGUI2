import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../elements"
import "../enums"

MGCard {
	id: root
	width: 300
	height: 200
	property string mccName: "实例名称"
	property string account: "xxxxx@xxx.com"
	property string yggdrasilName: "平台名称"
	property url imageSource: ""

	property int accountType: AccountType.Undefined

	enum MccState {
		Running,
		Stopped
	}
	property int mccState: MccCard.MccState.Stopped

	function getMccStateText() {
		switch (mccState) {
		case MccCard.MccState.Running:
			return "运行中"
		case MccCard.MccState.Stopped:
			return "未启动"
		default:
			return "未知状态"
		}
	}

	function getMccStateColor() {
		switch (mccState) {
		case MccCard.MccState.Running:
			return "lightgreen"
		case MccCard.MccState.Stopped:
			return "red"
		}
	}

	function closeMenu() {
		menu.close()
	}

	Column {
		id: mccInfo
		anchors.fill: parent
		spacing: 3
		padding: 10

		RowLayout {
			spacing: 10

			Image {
				id: mccImg
				source: root.imageSource
				fillMode: Image.PreserveAspectFit
				Layout.preferredWidth: mccInfo.width * 0.3
				Layout.preferredHeight: mccInfo.height * 0.3
			}
			
			Row {
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignVCenter
				padding: 10
				spacing: 6

				Rectangle {
					height: 10
					width: height
					radius: height / 2
					color: root.getMccStateColor()
					y: 5
				}

				MGText {
					text: root.getMccStateText()
					fontSize: 11
					color: "#333"
				}
			}
				
		}
			

		MGText {
			text: root.mccName
			bold: true
			fontSize: 13
			color: "#333"
		}

		MGText {
			text: AccountType.getString(root.accountType) + ((root.accountType === AccountType.Yggdrasil)? " - 平台名称" : "")
			fontSize: 9
			color: "#888"
		}

		MGText {
			text: root.account
			fontSize: 11
			color: "#444"
			elide: Text.ElideRight
		}
	}

	Row {
		id: tool
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		height: 40
		width: parent.width
		padding: 5
		spacing: 5
		layoutDirection: Qt.RightToLeft
		
		MGMoreButton {
			width: 15
			height: 25

			onClicked: {
				menu.open()
			}
			
			MGMenu {
				id: menu
				x: parent.width
				popupType: Popup.Window

				Repeater {
					model: ["启动/关闭", "重启", "编辑", "移动", "删除"]

					MGMenuItem {
						text: modelData
					}
				}
			}
		}

		MGButton {
			width: 50
			height: 25
			text: "启动"
			primaryColor: "#b3adff"
		}

		MGButton {
			width: 65
			height: 25
			text: "控制台"
		}
	}
}