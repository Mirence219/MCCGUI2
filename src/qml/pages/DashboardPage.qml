import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../items"

Page {
	id: root
	title: "Dashboard"

	background: null
	
	ServersBar {
		id: serversBar
		width: 50
		z: 2

		onServerClicked: (index) => {
			contentInner.setPage(index);
		}

		onAddServerClicked: {
			contentInner.setAddServerPage();
		}
	}

	Item {
		id: content
		anchors.fill: parent
		z: 1
		StackView {
			id: contentInner
			property int viewPadding: 10
		
			anchors.left: parent.left
			anchors.leftMargin: serversBar.width + viewPadding

			anchors.top: parent.top
			anchors.topMargin: viewPadding

			anchors.right: parent.right
			anchors.rightMargin: viewPadding

			anchors.bottom: parent.bottom
			anchors.bottomMargin: viewPadding

			initialItem: ServerPage { serverName: "服务器1" }
		
			function setPage(serverIndex) {
				replace(serverPageComponent, { 
					serverName: "服务器" + (serverIndex + 1),
					}, 
					StackView.Immediate);
			}

			function setAddServerPage() {
				replace(addServerPageComponent, {}, StackView.Immediate);
			}

			Component {
				id: serverPageComponent

				ServerPage {}
			}

			Component {
				id: addServerPageComponent

				AddServerPage {}
			}
		}
	}

	// 模糊快照
	ShaderEffectSource {
		id: contentSource
		sourceItem: content
		live: true
		recursive: true
		hideSource: serversBar.hovered
	}

	// 高斯模糊
	GaussianBlur {
		id: blur
		anchors.fill: parent
		source: contentSource
		radius: serversBar.hovered ? 8 : 0
		samples: 16
		opacity: serversBar.hovered ? 1 : 0
		visible: serversBar.hovered || opacity > 0
	}

	// 半透明遮罩
	Rectangle {
		anchors.fill: parent
		color: "#000000"
		opacity: serversBar.hovered ? 0.25 : 0.0
		visible: opacity > 0
		Behavior on opacity { NumberAnimation { duration: 180 } }
	}
}