import RealmSwift

final class DataHolder {
    static var sharedInstance = DataHolder()

    var realm: Realm?
    init() {
        do {
            realm = try Realm()
        } catch {
            realm = nil
            print("Not able to create Realm object")
        }
    }

    // write data into realm
    func writeData(data: List<DatabaseModel>) {
        do {
            try realm?.write {
                let dbItem = readData()
                if let item = dbItem?.first {
                    item.repoList.append(objectsIn: data)
                    realm?.add(item)
                } else {
                    let databaseItem = DatabaseItem()
                    databaseItem.repoList = data
                    realm?.add(databaseItem)
                }
            }
        } catch {
            print("Not able to write.")
        }
    }

    // read data from realm
    func readData() -> Results<DatabaseItem>? {
        let list = realm?.objects(DatabaseItem.self)
        return list
    }

    func deleteData() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            print("Not able to delete.")
        }
    }
}
