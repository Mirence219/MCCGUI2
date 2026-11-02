import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels
import "../elements"
import "../enums"
import "../objects/urlTool.js" as UrlTool

Page {
	id: root
	background: null

	signal clickBack
	property int serverIndex: 0

	property string serverName: `芒果方块（MangoCraft）`
	property string serverTitle: `互通 | 永不换挡 | 六年老服`
    property int serverState: ServerState.Running
    property url serverIcon: "../assets/test_server_icon.jpg"
    property int onlinePlayerNumber: 21     
    property int maxOnlinePlayerNumber: 200
	property real delay: 421.5
	property var serverIP: [`je.server.mangocraft.cn:25565`]
    property string serverVersion: "26.3"
	property int serverCoreType: ServerCoreType.Paper
	property var accountTypes: [AccountType.Microsoft, AccountType.Yggdrasil]
	property bool mccSupport: false
	property bool whiteList: false
	property var serverLink: [
		{"name": "服务器官网", "url": "https://mgcraft.net", "localIcon": ""},
		{"name": "MCMOD百科", "url": "https://play.mcmod.cn/sv20187251.html", "localIcon": "../assets/mcmod_favicon.ico"},
		{"name": "McLists", "url": "https://mclists.cn/server/9630.html", "localIcon": "../assets/mclists_favicon.ico"},
		{"name": "McServ", "url": "", "localIcon": "../assets/mcserv_favicon.ico"},
		{"name": "MineBBS", "url": "", "localIcon": "../assets/minebbs_favicon.webp"},
		{"name": "苦力怕论坛", "url": "https://klpbbs.com/thread-44869-1-1.html", "localIcon": "../assets/klpbbs_favicon.png"}
	]

	header:Row {
		spacing: 10

		MGButton {
			text: "←"
			onClicked: root.clickBack()
			anchors.verticalCenter: parent.verticalCenter
		}
		
		MGText {
			text: `${root.serverName} 信息`
			fontSize: 12
			bold: true
			anchors.verticalCenter: parent.verticalCenter
		}
		padding: 5
	}

	footer: Row {
		layoutDirection: Qt.RightToLeft
		spacing: 10

		MGButton {
			text: "添加服务器"
			fontSize: 15
			anchors.verticalCenter: parent.verticalCenter
		}
	}

	ScrollView {
		id: serverContentScrollView
		anchors.fill: parent
		contentWidth: width - 2 * padding
		contentHeight: serverInfo.height + 2 * serverInfo.padding
		padding: 5
		MGCard {
			width: parent.width
			height: serverInfo.height + 2 * serverInfo.padding

			ColumnLayout {
				id: serverInfo
				x: padding
				y: padding
				width: parent.width - 2 * padding
				spacing: 12
				property int padding: 12

				//服务器简介
				RowLayout {
					Layout.fillWidth: true
					Layout.preferredHeight: 100
					spacing: 20
					
					Item {
						Layout.fillHeight: true
						Layout.preferredWidth: height
						Image {
							height: parent.height * 0.8
							width: height
							anchors.centerIn: parent
							source: root.serverIcon
							fillMode: Image.PreserveAspectFit
						}
					}

					Column {
						Layout.alignment: Qt.AlignHCenter
						Layout.preferredWidth: 300
						spacing: 8

						MGText {
								text: root.serverName
								bold: true
								fontSize: 15
						}
						MGText {
							text: root.serverTitle
							fontSize: 13
						}
					}
					Column {
						Layout.alignment: Qt.AlignHCenter
						Layout.fillWidth: true
						spacing: 8

						Row {
							width: parent.width
							spacing: 5

							MGText {
								text: "状态 :"
								fontSize: 11
							}

							Rectangle {
								height: 12
								width: height
								radius: height / 2
								color: ServerState.getColor(root.serverState)
								y: 5
							}

							MGText {
								text: ServerState.getString(root.serverState)
								fontSize: 11
							}
						}

						MGText {
							text: `延迟：${root.delay}ms`
							fontSize: 11
						}
						MGText {
								text: `在线玩家：${root.onlinePlayerNumber} / ${root.maxOnlinePlayerNumber}`
								fontSize: 11
						}
					}
				}

				Rectangle { 
					Layout.preferredHeight:2
					Layout.fillWidth: true
					radius: 1
					color:"#bbb8b8ff" 
				}
				
				RowLayout {
					Layout.fillWidth: true
					spacing: 15

					//服务器信息
					Column {
						spacing: 8
						Layout.fillWidth: true
						Layout.alignment: Qt.AlignHCenter

						TableModel {
							id: tableModel
							TableModelColumn { display: "key" }
							TableModelColumn { display: "value" }
							rows: [
								{ key: "服务器IP", value: root.serverIP[0] },
								{ key: "游戏版本", value: root.serverVersion },
								{ key: "服务端类型", value: ServerCoreType.getString(root.serverCoreType) },
								{ key: "账户类型", value: AccountType.getStrings(root.accountTypes).join(" / ") },
								{ key: "白名单", value: root.whiteList ? "有" : "无" },
								{ key: "MCC支持", value: root.mccSupport ? "支持" : "无" }
							]
						}

						MGText { text: "服务器信息" }
						MGTable {
							width: parent.width
							model: tableModel
							columnList: ["信息", "内容"]
							headerEnable: false
						}
					}

					//相关链接
					Column {
						Layout.preferredWidth: serverInfo.width / 3
						Layout.fillHeight: true
						spacing: 8

						MGText { text: "相关链接：" }

						Flow {
							spacing: 10
							width: parent.width

							Repeater {
								model: root.serverLink

								MGButton {
									id: linkButton
									width: 70
									height: 70
									property var urlObj: new UrlTool.Url(modelData.url)
									visible: !urlObj.isEmpty()

									contentItem: Item {
										anchors.fill: parent
										Column {
											spacing: 4
											anchors.centerIn: parent
											Image {
												height: 30
												width: 30
												source: modelData.localIcon || linkButton.urlObj.icon
												anchors.horizontalCenter: parent.horizontalCenter
											}
											MGText {
												text: modelData.name
												fontSize: 8
												anchors.horizontalCenter: parent.horizontalCenter
											}
										}
									}

									onClicked: Qt.openUrlExternally(urlObj.url)
								}
							}
						}
					}
				}
			}
		}
	}
}