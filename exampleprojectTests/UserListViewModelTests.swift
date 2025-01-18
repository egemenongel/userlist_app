@testable import exampleproject
import XCTest

class UserListViewModelTests: XCTestCase {
    var viewModel: UserListViewModel!
    var mockService: MockUserService!
    
    override func setUp() {
        super.setUp()
        mockService = MockUserService()
        viewModel = UserListViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchUsers() {
        let expectation = self.expectation(description: "Users fetched successfully")
        
        viewModel.reloadData = {
            XCTAssertEqual(self.viewModel.numberOfUsers, 2)
            XCTAssertEqual(self.viewModel.user(at: 0).name, "John Doe")
            XCTAssertEqual(self.viewModel.user(at: 1).email, "janesmith@example.com")
            expectation.fulfill()
        }
        
        viewModel.fetchUsers()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
