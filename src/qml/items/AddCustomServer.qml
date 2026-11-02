import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../elements"

Page {
	id: root
	background: null

	ScrollView {
		id: scrollView
		anchors.fill: parent
		contentWidth: width
		contentHeight: form.implicitHeight + 60

		Item {
			id: content
			width: scrollView.width
			height: Math.max(form.implicitHeight, scrollView.height)

			Column {
				id: form
				anchors.centerIn: parent

				Component.onCompleted: console.log("parent:", parent.width, parent.height)
			
				MGText {
					anchors.horizontalCenter: parent.horizontalCenter
					text: "添加服务器"
					bold: true
					bottomPadding: 20
				}

				Grid {
					padding: 15
					rowSpacing: 8
					columnSpacing: 10
					columns: 2
					anchors.horizontalCenter: parent.horizontalCenter

					MGText {
						text: "服务器名称"
						fontSize: 13
						horizontalAlignment: Text.AlignRight
						verticalAlignment: Grid.AlignVCenter
					}

					MGInputLine {
						width: 250
						height: 30
						placeholderText: "服务器名称"
						horizontalAlignment: Grid.AlignLeft
						verticalAlignment: Grid.AlignVCenter
					}

					MGText {
						text: "服务器IP"
						fontSize: 13
						horizontalAlignment: Text.AlignRight
						verticalAlignment: Grid.AlignVCenter
					}

					MGInputLine {
						width: 250
						height: 30
						placeholderText: "服务器主IP地址"
						horizontalAlignment: Grid.AlignLeft
						verticalAlignment: Grid.AlignVCenter
					}
				}

				Column{
					id: moreServerIPWarp
					width: parent.width
			

					function addMoreServerIP() {
						moreServerIPListModel.append({});
					}

					function removeMoreServerIP(index) {
						moreServerIPListModel.remove(index);
					}

					Column {
						width: parent.width

						ListModel {
							id: moreServerIPListModel
						}

						Repeater {
							id: moreServerIPRepeater
							model: moreServerIPListModel

							Row {
								width: parent.width
								topPadding: 5
								bottomPadding: 5
								spacing: 8
					
								MGText {
									text: "备用IP " + index
								}

								MGInputLine {
									width: 250
									height: 30
									placeholderText: "备用IP地址" + index
								}

								MGButton {
									text: "-"
									onClicked: moreServerIPWarp.removeMoreServerIP(index)
								}
							}
						}
					}

					MGButton {
						text: "添加备用IP"
						fontSize: 12
						topPadding: 15

						onClicked: moreServerIPWarp.addMoreServerIP()
						
					}
				}

				MGButton {
					text: "添加服务器"
					enabled: false
					fontSize: 12
					anchors.horizontalCenter: parent.horizontalCenter
					topPadding: 15
				}
			}
		}

		
	}
}

