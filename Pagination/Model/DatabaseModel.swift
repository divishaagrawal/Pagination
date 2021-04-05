import Foundation
import RealmSwift

class DatabaseModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var desc = ""
    var items = List<ItemModel>()
}

class ItemModel: Object {
    @objc dynamic var iconName = ""
    @objc dynamic var value = ""

    override init() {}

    convenience init(iconName: String, value: String) {
        self.init()
        self.iconName = iconName
        self.value = value
    }
}

class DatabaseItem: Object {
    var repoList = List<DatabaseModel>()
}
