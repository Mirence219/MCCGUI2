import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../elements"

Page {
	id: root

	background: null

	enum AddServerType {
		Included,
		Custom
	}

	header:Item {
		width: parent.width
		height: tabBar.implicitHeight

		MGTabBar {
			id: tabBar
			anchors.horizontalCenter: parent.horizontalCenter
			MGTabButton {
				text: "已收录服务器"

				onClicked: {
					addServerStackView.setMode(AddServerPage.Included);
				}
			}

			MGTabButton {
				text: "自定义服务器"

				onClicked: {
					addServerStackView.setMode(AddServerPage.Custom);
				}
			}
		}
	}
	
	StackView {
		id: addServerStackView
		anchors.fill: parent

		initialItem: addIncludedServerComponent

		function setMode(addServerType: int){
			switch (addServerType) {
				case AddServerPage.Included: 
					replace(addIncludedServerComponent, {}, StackView.Immediate);break;
				case AddServerPage.Custom: 
					replace(addCustomServerComponent, {}, StackView.Immediate);
			}
		}
	}
	Component {
		id: addCustomServerComponent

		AddCustomServer {}
	}

	Component {
		id: addIncludedServerComponent

		AddIncludedServer {}
	}
}