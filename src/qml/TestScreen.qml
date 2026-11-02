import QtQuick
import QtQuick.Controls
import "./elements" as Elements

Rectangle {
	id: root

	color: "#f6f6fe"
	
	Column {
		Elements.MGText {
			id: myTitle
			text: "Hello, Qt Quick!"
			fontSize: 20 + 4
		}

		Elements.MGButton {
			id: myButton
			width: 100
			height: 40
		}

		Elements.MGCard {
			id: myCard
			width: 300
			height: 150
		}

		Elements.MGRadio {
			id: myRadio
			text: "单选框文本1"
			checked: true;
		}
		Elements.MGRadio {
			id: myRadio2
			text: "单选框文本2"
		}
		Elements.MGRadio {
			id: myRadio3
			text: "单选框文本3"
		}

		Elements.MGCheckBox {
			id: myCheckBox1
			text: "复选框文本1"
		}
		Elements.MGCheckBox {
			id: myCheckBox2
			text: "复选框文本2"
		}
		Elements.MGCheckBox {
			id: myCheckBox3
			text: "复选框文本3"
		}
		Elements.MGInputLine {
			id: myInputLine
			width: 200
			height: 40
		}
	}
}
