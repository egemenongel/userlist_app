//
//  UserDetailServiceTest.swift
//  exampleproject
//
//  Created by Egemen Öngel on 19.01.2025.
//

@testable import exampleproject
import XCTest

class UserDetailServiceTests: XCTestCase {
    var userDetailService: UserDetailService!
    var mockRepository: MockUserDetailRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockUserDetailRepository()
        userDetailService = UserDetailService(repository: mockRepository)
    }
    
    override func tearDown() {
        userDetailService = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testFetchUserDetailsSuccess() {
        let expectation = self.expectation(description: "fetchUserDetails")
        let testUserId = 1
        
        userDetailService.fetchUserDetails(userId: testUserId) { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.id, 1)
                XCTAssertEqual(user.name, "John Doe")
                XCTAssertEqual(user.email, "johndoe@example.com")
            case .failure:
                XCTFail("Expected success, but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchUserDetailsFailure() {
        let expectation = self.expectation(description: "fetchUserDetails")
        let testUserId = 99 // Simulating a failure case
        
        mockRepository.shouldReturnError = true
        
        userDetailService.fetchUserDetails(userId: testUserId) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Failed to fetch user details")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
