import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../elements"

Page {
    id: root
    background: null

    signal clickServer(var index)
    signal clickBack

    header:Row {
        MGText {
            text: "在下列服务器中选择一个进行添加："
            fontSize: 12
        }

        MGText {
            text: "（没有你正在玩的？点此处提交服务器信息。）"
            fontSize: 11
            font.underline: true
        }
        padding: 5
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        Rectangle {
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            color: "#dde0e0ff"
            radius: 10
            RowLayout {
                anchors.fill: parent
                
                MGText {
                    text: "服务器名称"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredWidth: parent.width * 0.4
                }

                MGText {
                    text:"IP地址"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignCenter
                    Layout.fillWidth: true
                }
            }
        }

        ListView {
            id: serverItemListView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            model: 30

            delegate: ItemDelegate {
                id: serverItem
                width: ListView.view.width
                height: 50

                background: Rectangle {
                    color: serverItem.pressed ? Qt.darker("#dde0e0ff", 1.1) : (serverItem.hovered ? Qt.darker("#dde0e0ff", 1.05) : "#dde0e0ff")
                    topRightRadius: index == 0 ? 5 : 0
                    topLeftRadius: index == 0 ? 5 : 0
                    bottomRightRadius: index == (serverItemListView.model - 1)? 5 : 0
                    bottomLeftRadius: index == (serverItemListView.model - 1) ? 5 : 0
                }
                
                RowLayout {
                    anchors.fill: parent

                    Row {
                        Layout.fillHeight: true
                        Layout.preferredWidth: parent.width * 0.4
                        padding: 10
                        spacing: 10
                        
                        Image {
                            height: parent.height * 0.6
                            width: height
                            anchors.verticalCenter: parent.verticalCenter
                            source: "../assets/unknown_server.png"
							fillMode: Image.PreserveAspectFit
                        }
                        MGText {
                            text: "服务器" + (index + 1) + `(Server ${index + 1})`
                            anchors.verticalCenter: parent.verticalCenter
                            elide: Text.ElideRight
                        }
                    }

                    MGText {
                        text: "server" + (index + 1) + ".com"
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                onClicked: root.clickServer(index)
            }
        }
    }
}
