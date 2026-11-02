import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Layouts
import "../elements"
import "../enums"

MGCard {
	id: root
	height: 80
	width: parent.width

    property string serverName: "服务器名称"
    property url serverIcon: "../assets/unknown_server.png"
    property int onlinePlayerNumber: 0      
    property int maxOnlinePlayerNumber: 0
    property string serverWelcome: "服务器欢迎文本"
    property string serverVersion: "0.0.0"
    property int serverState: ServerState.Undefined

    property int padding: 10

    RowLayout {
		spacing: 10
		anchors.centerIn: parent
        width: parent.width - 2 * root.padding
        height: parent.height - 2 * root.padding



		Item {
            id: icon
            Layout.preferredWidth: 60
            Layout.preferredHeight: 60

            Image {
                id: img
                anchors.fill: parent
                source: "../assets/unknown_server.png"
                fillMode: Image.PreserveAspectFit
                visible: false
            }

            Rectangle {
                id: roundMask
                anchors.fill: parent
                radius: 10
                visible: false
            }

            OpacityMask {
                anchors.fill: img
                source: img
                maskSource: roundMask
            }
        }

        Column {
            id: mainInfo
            Layout.preferredWidth: 150
            Layout.alignment: Qt.AlignHCenter
            MGText {
                text: root.serverName
                fontSize: 15
                bold: true
            }

            MGText {
                text: `<font color="${ServerState.getColor(root.serverState)}">●</font> 在线人数：` + root.onlinePlayerNumber + " / " + root.maxOnlinePlayerNumber
                fontSize: 12
            }
        }

        Item {
            id: welcome
            Layout.minimumWidth: 100
            Layout.preferredHeight: 60
            Layout.fillWidth: true
            MGText {
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: root.serverWelcome
                wrapMode: Text.WordWrap
                fontSize: 15
                fontFamily: "Minecraft AE"
            }
        }

        Item {
            id: otherInfo
            Layout.preferredWidth: 150
            Layout.preferredHeight: 60

            Column {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 5

                MGText {
                    text: "游戏版本 :" + root.serverVersion
                    fontSize: 12
                }
                Row{
                    width: parent.width
                    spacing: 5

                    MGText {
                        id: stateText
                        text: "状态 :"
                        fontSize: 12
                    }

                    Rectangle {
                        height: 13
                        width: height
                        radius: height / 2
                        color: ServerState.getColor(root.serverState)
                        y: 5
                    }

                    MGText {
                        text: ServerState.getString(root.serverState)
                        fontSize: 12
                    }
                }
            }
        }
	}
}