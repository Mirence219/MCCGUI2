//统计对象集合是否存在hovered
import QtQuick 2.15

Timer {
	id: root

	property var entities: ({})
	property bool hovered: false
	property bool instantHovered: Object.values(entities).some(v => v)	//对象集合中是否存在hovered为true的对象


	onTriggered: {
		hovered = instantHovered;
	}

	function register(id) {
		const copy = Object.assign({}, entities)
		copy[id] = false;
		entities = copy;
	}

	function unregister(id) {
		const copy = Object.assign({}, entities)
		delete copy[id];
		entities = copy;
	}
	
	function update(id, hovered) {
		const copy = Object.assign({}, entities)
		copy[id] = hovered;
		entities = copy;
	}

	onInstantHoveredChanged: {
		if (instantHovered) {
			stop();
			hovered = instantHovered;
		}
		else {
			restart();
		}
	}
}