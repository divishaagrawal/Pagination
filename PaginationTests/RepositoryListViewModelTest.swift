@testable import Pagination
import XCTest

class RepositoryListViewModelTest: XCTestCase {
    var viewModel: RepositoryListViewModel!
    var response: RepositoryResponse!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = RepositoryListViewModel(completion: setResponse(response:))
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func setResponse(response: RepositoryResponse?) {
        self.response = response
    }
}

extension RepositoryListViewModelTest {
    func test_fetchData() {
        viewModel.fetchData()
        let expectation = XCTestExpectation(description: "wait time")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
}
