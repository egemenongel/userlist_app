//
//  UserListService.swift
//  exampleproject
//
//  Created by Egemen Öngel on 19.01.2025.
//

@testable import exampleproject
import XCTest

class UserServiceTests: XCTestCase {
    var userService: UserService!
    var mockRepository: MockUserRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockUserRepository()
        userService = UserService(repository: mockRepository)
    }
    
    override func tearDown() {
        userService = nil
        mockRepository = nil
        super.tearDown()
    }

    func testFetchUsersSuccess() {
        let expectation = self.expectation(description: "fetchUsers")
        
        userService.fetchUsers { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 2)
                XCTAssertEqual(users[0].name, "John Doe")
                XCTAssertEqual(users[1].name, "Jane Smith")
            case .failure:
                XCTFail("Expected success, but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchUsersFailure() {
        let expectation = self.expectation(description: "fetchUsers")
        
        mockRepository.shouldReturnError = true
        
        userService.fetchUsers { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Failed to fetch users")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
