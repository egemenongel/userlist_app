//
//  UserDetailViewModelTests.swift
//  exampleproject
//
//  Created by Egemen Öngel on 18.01.2025.
//

@testable import exampleproject
import XCTest

class UserDetailViewModelTests: XCTestCase {
    var viewModel: UserDetailViewModel!
    var user: User!
    
    override func setUp() {
        super.setUp()
        user = User(id: 1, name: "John Doe", email: "johndoe@example.com", phone: "123-456-7890", website: "johndoe.com")
        viewModel = UserDetailViewModel(user: user)
    }
    
    override func tearDown() {
        viewModel = nil
        user = nil
        super.tearDown()
    }
    
    func testUserDetailViewModel() {
        XCTAssertEqual(viewModel.name, "John Doe")
        XCTAssertEqual(viewModel.email, "johndoe@example.com")
        XCTAssertEqual(viewModel.phone, "123-456-7890")
        XCTAssertEqual(viewModel.website, "johndoe.com")
    }
}
