import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: root
    width: parent.width
    height: tableHeader.height + tableContent.height

    property var model
    // 格式：[{ name: "roleKey", display: "表头文字" }]
    property var columnList: []
    property int blockHeight: 30
    property int radius: 10
    property int rowSpacing: 0
    property int columnSpacing: 0
    property bool headerEnable: true

    // 表头
    Rectangle {
        id: tableHeader
        color: "#ccccff"
        width: root.width
        height: root.headerEnable ? root.blockHeight : 0
        topLeftRadius: root.radius
        topRightRadius: root.radius
        visible: root.headerEnable

        RowLayout {
            anchors.fill: parent
            spacing: 1
            Repeater {
                model: root.columnList
                MGText {
                    Layout.fillWidth: true
                    Layout.minimumWidth: 60
                    text: modelData
                    bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }

    // 表格主体
    TableView {
        id: tableContent
        anchors.top: tableHeader.bottom
        width: root.width
        height: contentHeight
        clip: true
        rowSpacing: root.rowSpacing
        columnSpacing: root.columnSpacing
        ScrollBar.vertical: ScrollBar {}

        model: root.model

        //对齐表头
        columnWidthProvider: function(col) {
            return root.width / root.columnList.length
        }
        rowHeightProvider: function() {return root.blockHeight}

        delegate: Rectangle {
            color: "#e0e0ff"
            border.width: 1
            border.color: "#ccccff"

            required property var model
            required property int column
            required property bool selected

            MGText {
                anchors.centerIn: parent
                fontSize: 11
                text: display
            }
        }
    }
}
