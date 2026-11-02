import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtQuick.Layouts
import "../elements"
import "../objects"

Item {
	id: root
	height: parent.height
	width: 50

	property alias currentIndex: tabBar.currentIndex
	property bool hovered: hoverTracker.hovered
	property int serverCount: 20
	
	signal serverClicked(int index)
	signal addServerClicked

	onHoveredChanged: {
		console.log("Hovered Changed");
	}
	
	HoverTracker {
		id: hoverTracker
		interval: 60
	}

	Rectangle {
		id: background
		anchors.left: parent.left
		anchors.verticalCenter: parent.verticalCenter
		height: parent.height - 20
		color: "#9696ff"
		topRightRadius: 10
		bottomRightRadius: 10
		width: root.hovered ? parent.width * 3 : parent.width

		Behavior on width {
			NumberAnimation { duration: 100 }
		}
	}

	Rectangle {
		id: shapeMask
		anchors.left: parent.left
		anchors.verticalCenter: parent.verticalCenter
		width: background.width
		height: parent.height - 20
		color: "white"
		topRightRadius: 10
		bottomRightRadius: 10
		visible: false
	}

	OpacityMask {
		anchors.fill: tabBar
		maskSource: shapeMask
		source: tabBar
	}
	
	ListView {
		id: tabBar
		anchors.fill: background
		spacing: 0
		currentIndex: 0
		highlightMoveDuration: 200
		opacity: 0
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		
		property int hoverCount: 0

		model: {
			const lst = [];
			for (let i = 1; i <= root.serverCount; i++) {
				lst.push(`服务器${i}`);
			}
			return lst;
		}
		
		delegate: RadioDelegate {
			id: serverTab
			width: tabBar.width
			height: 50
			checked: index == tabBar.currentIndex

			background: Rectangle {
				color: serverTab.checked ? "#f6f6fe" : (
						serverTab.pressed ? Qt.darker("#9696ff", 1.1) : (
						serverTab.hovered ? Qt.darker("#9696ff", 1.05):"transparent")) 
				anchors.fill: parent
				}

			contentItem:
				Item {
					anchors.fill: parent

					MouseArea {
						anchors.fill: parent
						acceptedButtons: Qt.RightButton 
						onClicked: (event) => {
							if (event.button === Qt.RightButton) {
								serverMenu.popup(event.x - serverMenu.parent.x - 4, event.y - serverMenu.parent.y - 8);
							}
						}
					}
					RowLayout {
						anchors.verticalCenter: parent.verticalCenter
						width: parent.width  - 20
						spacing: 10
						x: 10

						Image {
							Layout.preferredWidth: serverTab.height * 0.6
							Layout.preferredHeight: serverTab.height * 0.6
							source: "../assets/unknown_server.png"
							fillMode: Image.PreserveAspectFit
						}

						MGText {
							text: modelData
							fontSize: 12
							color: serverTab.checked ? "black" : "white"
							horizontalAlignment: Text.AlignLeft
							verticalAlignment: Text.AlignVCenter
							elide: Text.ElideRight
							Layout.fillWidth: true
							Layout.alignment: Qt.AlignVCenter
						}

						MGMoreButton {
							Layout.preferredWidth: 5
							Layout.preferredHeight: 20
							Layout.alignment: Qt.AlignRight | Qt.AlignVCenter 
							color: hovered ? "#8e43fe" : (serverTab.checked ? "#9696ff" : "#f6f6fe")

							onClicked: {
								serverMenu.popup(10, 0)
							}

							MGMenu {
								id: serverMenu
								x: parent.width
								popupType: Popup.Window

								Repeater {
									model: ["编辑", "删除", "移动"]
									MGMenuItem {
										id: menuItem
	
										text: modelData

										onHoveredChanged: {
											hoverTracker.update(menuItem, hovered)
										}

										Component.onCompleted: {
											hoverTracker.register(menuItem);
										}
									}
								}
							}

							Connections {
								target: tabBar

								function onMovementStarted() {
									serverMenu.close();
								}
							}

							Connections {
								target: root
								
								function onHoveredChanged() {
									if (!root.hovered) {
										serverMenu.close();
									}
								}
							}
						}
					}
				}

			indicator: null

			onClicked: {
				console.info("[INFO] 点击" + modelData)
				currentIndex = index;
				root.serverClicked(index)
			}

			onHoveredChanged: {
				hoverTracker.update(serverMenu, hovered)
			}
	
			Component.onCompleted: {
				hoverTracker.register(serverTab);
			}
		}
	}

	MGButton {
		id: addServerBtn
		text: root.hovered ? "+ 添加服务器" : "+"
		fontSize: root.hovered ? 14 : 20
		bold: true
		textColor: hovered ? "white" : "#333333"
		width: background.width
		height: 50
		anchors.bottom: background.bottom
		anchors.left: background.left

		background: Rectangle {
			bottomRightRadius: 10
			color: addServerBtn.pressed ? addServerBtn.primaryPress : (addServerBtn.hovered ? addServerBtn.primaryHover : addServerBtn.primaryColor)
		}

		onHoveredChanged: {
			hoverTracker.update(addServerBtn, hovered)
		}
	
		Component.onCompleted: {
			hoverTracker.register(addServerBtn);
		}

		onClicked: {
			root.addServerClicked();
		}
	}
}