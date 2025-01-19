//
//  UserListViewModelTest.swift
//  exampleproject
//
//  Created by Egemen Öngel on 19.01.2025.
//

@testable import exampleproject
import XCTest

// Mock UserService for testing
class MockUserService: UserServiceProtocol {
    var fetchUsersResult: Result<[User], Error>?
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        if let result = fetchUsersResult {
            completion(result)
        }
    }
}

// Test case for UserListViewModel
class UserListViewModelTests: XCTestCase {
    var viewModel: UserListViewModel!
    var mockService: MockUserService!
    let testUsers = [
        User(id: 1, name: "John Doe", email: "johndoe@example.com", phone: "123456", website: "some-website"),
        User(id: 2, name: "Jane Smith", email: "janesmith@example.com", phone: "02468", website: "some-website2")
    ]
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
    
    // Test for successful fetch of users
    func testFetchUsersSuccess() {
        // Given
        let expectedUsers = testUsers
        mockService.fetchUsersResult = .success(expectedUsers)
        
        // When
        var reloadDataCalled = false
        viewModel.reloadData = {
            reloadDataCalled = true
        }
        
        viewModel.fetchUsers()
        
        // Then
        XCTAssertTrue(reloadDataCalled)
        XCTAssertEqual(viewModel.numberOfUsers, 2)
        XCTAssertEqual(viewModel.user(at: 0).name, "John Doe")
        XCTAssertEqual(viewModel.user(at: 1).name, "Jane Smith")
    }
    
    // Test for failed fetch of users
    func testFetchUsersFailure() {
        // Given
        mockService.fetchUsersResult = .failure(NSError(domain: "", code: 0, userInfo: nil))
        
        // When
        var reloadDataCalled = false
        viewModel.reloadData = {
            reloadDataCalled = true
        }
        
        viewModel.fetchUsers()
        
        // Then
        XCTAssertFalse(reloadDataCalled) // reloadData shouldn't be called on failure
        XCTAssertEqual(viewModel.numberOfUsers, 0)
    }
    
    // Test for number of users property
    func testNumberOfUsers() {
        // Given
        let users = testUsers
        mockService.fetchUsersResult = .success(users)
        
        // When
        viewModel.fetchUsers()
        
        // Then
        XCTAssertEqual(viewModel.numberOfUsers, 2)
    }
    
    // Test for accessing user at index
    func testUserAtIndex() {
        // Given
        let users = testUsers
        mockService.fetchUsersResult = .success(users)
        
        // When
        viewModel.fetchUsers()
        
        // Then
        XCTAssertEqual(viewModel.user(at: 0).name, "John Doe")
        XCTAssertEqual(viewModel.user(at: 1).name, "Jane Smith")
    }
}
