//
//  UserTableViewControllerTests.swift
//  UsersAndPostsTests
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import UIKit
import XCTest
@testable import UsersAndPosts


class UserTableViewControllerTests: XCTestCase {
    var sut: UserTableViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "UserTableViewController") as! UserTableViewController
    }
    
    func testDataLoadedFromFakeAPI() {
        let apiClient = FakeAPIClient()
        apiClient.fail = false
        sut.apiClient = apiClient
        _ = sut.view

        XCTAssertEqual(sut.tableView.numberOfSections, 1)
        XCTAssertEqual(sut.tableView.visibleCells.count, 2)
    }
    
    func testDataNotLoadedFromFakeAPI() {
        let apiClient = FakeAPIClient()
        apiClient.fail = true
        sut.apiClient = apiClient
        _ = sut.view
        
        XCTAssertEqual(sut.tableView.numberOfSections, 1)
        XCTAssertEqual(sut.tableView.visibleCells.count, 0)
    }
    
    func testDataCleaned() {
        let apiClient = FakeAPIClient()
        apiClient.fail = false
        sut.apiClient = apiClient
        _ = sut.view
        
        XCTAssertEqual(sut.tableView.numberOfSections, 1)
        XCTAssertEqual(sut.tableView.visibleCells.count, 2)
    }
}

