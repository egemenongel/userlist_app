//
//  UserListViewControllersTest.swift
//  exampleproject
//
//  Created by Egemen Öngel on 18.01.2025.
//

@testable import exampleproject
import XCTest

class UserListViewControllerTests: XCTestCase {
    var viewController: UserListViewController!
    var viewModel: UserListViewModel!
    var mockService: MockUserService!
    
    override func setUp() {
        super.setUp()
        mockService = MockUserService()
        viewModel = UserListViewModel(service: mockService)
        viewController = UserListViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewController = nil
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testViewDidLoad() {
        let expectation = self.expectation(description: "Data reloads successfully")
        
        viewModel.reloadData = {
            XCTAssertTrue(self.viewController.tableView.numberOfRows(inSection: 0) > 0)
            expectation.fulfill()
        }
        
        viewController.viewDidLoad()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
