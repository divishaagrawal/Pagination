@testable import Pagination
import RealmSwift
import XCTest

class DataholderTest: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

extension DataholderTest {
    func test_fetchData() {
        let list = List<DatabaseModel>()
        let model = DatabaseModel()
        model.name = "Git"
        model.desc = "Git repo"
        let itemModel = ItemModel(iconName: "bookmark", value: "3")
        model.items.append(itemModel)
        list.append(model)
        DataHolder.sharedInstance.writeData(data: list)
        XCTAssertNotNil(DataHolder.sharedInstance.readData())
    }
}
