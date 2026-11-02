pragma Singleton
import QtQuick

QtObject {
	enum ServerCoreType {
		//Vanilla原版端
		Vanilla,

		//Bukkit插件端
		Paper,
		Purpur,
		Leaves,
		Luminol,
		Lophine,
		Folia,
		Pufferfish,
		Spigot,

		//Mod模组端
		Fabric,
		Quilt,
		NeoForge,
		Forge,

		//混合端
		Mohist,
		Arclight,
		CatServer,
		Sponge,

		//其他
		Other,
		Undefined,
		Count
	}

	property var serverCoreTypeList: [
        "Vanilla",
        "Paper",
        "Purpur",
        "Leaves",
        "Luminol",
        "Lophine",
        "Folia",
        "Pufferfish",
        "Spigot",
        "Fabric",
        "Quilt",
        "NeoForge",
        "Forge",
        "Mohist",
        "Arclight",
        "CatServer",
        "Sponge",
        "其他",
        "未知"
    ]

	function getString(type: int): string {
        if (type < 0 || type >= ServerCoreType.Count) {
            return serverCoreTypeList[ServerCoreType.Undefined]
        }
        return serverCoreTypeList[type];
    }

	function isValid(type: int): bool {
        return type >= 0 && type < ServerCoreType.Count && type !== ServerCoreType.Undefined
    }
}

