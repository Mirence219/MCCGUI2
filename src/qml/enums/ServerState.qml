pragma Singleton
import QtQuick

QtObject {
	enum ServerState {
        Closed,
        Running,
        Maintenance,
        Undefined,
        Count
    }

	property var serverStateList: [
        "已关闭",
		"运行中",
		"维护中",
        "未知状态"
    ]

    property var serverStateColorList: [
        "red",
        "lightgreen",
        "gray",
        "gray"
    ]

	function getString(type: int): string {
        if (type < 0 || type >= ServerState.Count) {
            return serverStateList[ServerState.Undefined];
        }
        return serverStateList[type];
    }

	function getColor(type: int): string {
        if (type < 0 || type >= ServerState.Count) {
            return serverStateColorList[ServerState.Undefined];
        }
        return serverStateColorList[type];
    }

	function isValid(type: int): bool {
        return type >= 0 && type < ServerState.Count && type !== ServerState.Undefined
    }
}

