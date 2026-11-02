import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../items"
import "../elements"

Page {
	id: root
	title: serverName

	property alias serverName: serverInfo.serverName
	property alias scrollEnabled: mccCardsScrollView.wheelEnabled
	
	scrollEnabled: !serversBar.hovered	//此行应该放在外部
		
	background: null

	ColumnLayout {
		id: contentInner
		anchors.fill: parent
		spacing: 0

		ServerInfo {
			id: serverInfo
			Layout.fillWidth: true
		}

		Row {
			id: tool
			Layout.preferredHeight: 50
			Layout.fillWidth: true
			topPadding: 10
			bottomPadding: 10
			spacing: 10

			property int buttonWidth: 80
			property int fontSize: 11

			MGButton {
				height: parent.height - tool.topPadding - tool.bottomPadding
				width: tool.buttonWidth
				text: "添加实例"
				fontSize: tool.fontSize
			}

			MGButton {
				height: parent.height - tool.topPadding - tool.bottomPadding
				width: tool.buttonWidth
				text: "批量选择"
				fontSize: tool.fontSize
			}
		}

		ScrollView {
			id: mccCardsScrollView
			Layout.fillWidth: true
			Layout.fillHeight: true

			ScrollBar.vertical.policy: ScrollBar.AlwaysOff

			Flow {
				id: mccCards
				spacing: 15
				width: parent.width

				property int columnCount: 4
			
				Repeater {
					model: 10
					MccCard {
						id: mccCard
						width: (mccCards.width - (mccCards.columnCount - 1) * mccCards.spacing) / mccCards.columnCount
						height: 180
						mccName: "实例" + (index + 1)
						imageSource: "../assets/MCC_logo.png"

						Connections {
							target: mccCardsScrollView.contentItem
							function onMovementStarted() {
								mccCard.closeMenu();
							}
						}
					}
				}
			}
		}
		
			
	}
}