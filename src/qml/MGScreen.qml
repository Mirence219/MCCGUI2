import QtQuick
import QtQuick.Controls
import "items"
import "pages"

Rectangle {
	id: root
	
	width: 800
	height: 500

	color: "#f6f6fe"

	readonly property alias indexHeight: index.height

	//导航栏
	Index {
		id: index

		onCurrentIndexChanged: {
			view.setView(currentIndex);
		}
	}

	//页面内容
	StackView {
		id: view
		anchors.top: index.bottom
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.right: parent.right

		property int lastIndex: 0

		property list<Page> pageType : [
			dashboard,
			account,
			download,
			setting
		]

		function setView(pageIndex) {
			if (currentItem != pageIndex) {
				if (pageIndex > lastIndex) {
					replace(pageType[pageIndex], {}, StackView.PushTransition)
				}
				else {
					replace(pageType[pageIndex], {}, StackView.PopTransition);
				}
			}
			lastIndex = pageIndex;
			console.debug("[DEBUG] 页面已更改为" + pageType[pageIndex].title)
		}

		initialItem: pageType[0]
		
		//仪表盘
		DashboardPage { id: dashboard; visible: false }
		//账户
		AccountPage { id: account; visible: false }
		//下载
		DownloadPage { id: download; visible: false }
		//设置
		SettingPage { id: setting; visible: false }
	}
}