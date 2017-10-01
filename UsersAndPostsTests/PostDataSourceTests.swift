//
//  PostDataSourceTests.swift
//  UsersAndPostsTests
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import UIKit
import XCTest
@testable import UsersAndPosts


class PostsDataSourceTests: XCTestCase {
    
    var dataSource: DataSource<Post>!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        let post = StubLoader().postFromStub()

        dataSource = DataSource<Post>(data: [post, post, post], dataType: DataType.posts)
        tableView = UITableView()
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: Post.cellIdentifier())
        tableView.dataSource = dataSource
        tableView.reloadData()
        tableView.awakeFromNib()
    }
    
    func testDataSourceNumberOfItems() {
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 3)
        XCTAssertEqual(dataSource.numberOfSectionsInTableView(tableView: tableView), 1)
    }
    
    func testDataSourceContent() {
        XCTAssertNil(dataSource.tableView(tableView, titleForHeaderInSection: 0))
        let postCell = dataSource.tableView(tableView, cellForRowAt: IndexPath(item: 2, section: 0)) as! PostCell
        
        XCTAssertEqual(postCell.titleLabel.text, "in quibusdam tempore odit est dolorem")
        XCTAssertEqual(postCell.bodyLabel.text, "itaque id aut magnam\npraesentium quia et ea odit et ea voluptas et\nsapiente quia nihil amet occaecati quia id voluptatem\nincidunt ea est distinctio odio")
    }
}
