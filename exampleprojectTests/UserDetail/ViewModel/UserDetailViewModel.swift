@testable import exampleproject
import XCTest

class MockUserDetailService: UserDetailServiceProtocol {
    var fetchUserDetailsResult: Result<User, Error>?
    
    func fetchUserDetails(userId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        if let result = fetchUserDetailsResult {
            completion(result)
        }
    }
}

class UserDetailViewModelTests: XCTestCase {
    var viewModel: UserDetailViewModel!
    var mockService: MockUserDetailService!
    let testUser = User(id: 1, name: "John Doe", email: "johndoe@example.com", phone: "", website: "")
    override func setUp() {
        super.setUp()
        mockService = MockUserDetailService()
        viewModel = UserDetailViewModel(service: mockService, userId: 1)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchUserDetailsSuccess() {
        let expectedUser = testUser
        mockService.fetchUserDetailsResult = .success(expectedUser)
        
        let expectation = self.expectation(description: "User details fetch completed")
        
        var userReceived: User?
        viewModel.user = { user in
            userReceived = user
            expectation.fulfill()
        }
        
        var errorReceived: String?
        viewModel.error = { error in
            errorReceived = error
            expectation.fulfill()
        }
        
        viewModel.fetchUserDetails()

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error, "Timeout occurred while waiting for user details fetch")
            XCTAssertNotNil(userReceived)
            XCTAssertEqual(userReceived?.name, "John Doe")
            XCTAssertEqual(userReceived?.email, "johndoe@example.com")
            XCTAssertNil(errorReceived)
        }
    }
    
    func testFetchUserDetailsFailure() {
        mockService.fetchUserDetailsResult = .failure(NSError(domain: "", code: 0, userInfo: nil))
        
        let expectation = self.expectation(description: "User details fetch completed")
        
        var userReceived: User?
        viewModel.user = { user in
            userReceived = user
            expectation.fulfill()
        }
        
        var errorReceived: String?
        viewModel.error = { error in
            errorReceived = error
            expectation.fulfill()
        }
        
        viewModel.fetchUserDetails()
        
        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error, "Timeout occurred while waiting for user details fetch")
            
            XCTAssertNil(userReceived)
            XCTAssertNotNil(errorReceived)
            XCTAssertEqual(errorReceived, "The operation couldn’t be completed. ( error 0.)")
        }
    }
    
    func testUserCallback() {
        let expectedUser = testUser
        mockService.fetchUserDetailsResult = .success(expectedUser)
        
        let expectation = self.expectation(description: "User details fetch completed")
        
        var userReceived: User?
        viewModel.user = { user in
            userReceived = user
            expectation.fulfill()
        }
        
        viewModel.fetchUserDetails()
        
        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error, "Timeout occurred while waiting for user details fetch")
            XCTAssertNotNil(userReceived)
            XCTAssertEqual(userReceived?.name, "John Doe")
            XCTAssertEqual(userReceived?.email, "johndoe@example.com")
        }
    }
    
    func testErrorCallback() {
        mockService.fetchUserDetailsResult = .failure(NSError(domain: "", code: 0, userInfo: nil))
        let expectation = self.expectation(description: "User details fetch completed")
        var errorReceived: String?
        viewModel.error = { error in
            errorReceived = error
            expectation.fulfill()
        }
        
        viewModel.fetchUserDetails()
        
        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error, "Timeout occurred while waiting for user details fetch")
            XCTAssertNotNil(errorReceived)
            XCTAssertEqual(errorReceived, "The operation couldn’t be completed. ( error 0.)")
        }
    }
}
