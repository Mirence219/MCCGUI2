pragma Singleton
import QtQuick

QtObject {
	enum AccountType {
		Microsoft,
		OffLine,
		Yggdrasil,
		Undefined,
		Count
	}

	property var accountTypeList: [
        "正版账户",
		"离线账户",
		"外置账户",
        "未知账户"
    ]

	function getString(type: int): string {
        if (type < 0 || type >= AccountType.Count) {
            return accountTypeList[AccountType.Undefined];
        }
        return accountTypeList[type];
    }

	function isValid(type: int): bool {
        return type >= 0 && type < AccountType.Count && type !== AccountType.Undefined
    }

	function getStrings(types: var): var {
        const res = [];
        for(let i = 0; i < types.length; i++){
            res.push(getString(types[i]));
        }
        return res;
    }
}

