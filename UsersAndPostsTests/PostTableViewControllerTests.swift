//
//  PostTableViewControllerTests.swift
//  UsersAndPostsTests
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import UIKit
import XCTest
@testable import UsersAndPosts


class PostTableViewControllerTests: XCTestCase {
    var sut: PostTableViewController!
    var apiClient: FakeAPIClient = FakeAPIClient()
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "PostTableViewController") as! PostTableViewController
    }
    
    func testDataLoadedFromFakeAPI() {
        sut.apiClient = apiClient
        apiClient.fail = false
        let user = StubLoader().userFromStub()
        sut.fetchPostsAsync(for: user)
        _ = sut.view
        
        XCTAssertEqual(sut.tableView.numberOfSections, 1)
        XCTAssertEqual(sut.tableView.visibleCells.count, 3)
    }
    
    func testDataNotLoadedFromFakeAPI() {
        sut.apiClient = apiClient
        apiClient.fail = true
        let user = StubLoader().userFromStub()
        sut.fetchPostsAsync(for: user)
        _ = sut.view
        
        XCTAssertEqual(sut.tableView.numberOfSections, 1)
        XCTAssertEqual(sut.tableView.visibleCells.count, 0)
    }
}
