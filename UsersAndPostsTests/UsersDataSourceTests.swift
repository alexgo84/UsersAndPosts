//
//  UsersDataSourceTests.swift
//  UsersAndPostsTests
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import UIKit
import XCTest
@testable import UsersAndPosts


class UsersDataSourceTests: XCTestCase {
    
    var dataSource: DataSource<User>!
    var tableView: UITableView!

    override func setUp() {
        super.setUp()
        let user1 = StubLoader().userFromStub()
        let user2 = StubLoader().emptyUserFromStub()
        
        dataSource = DataSource<User>(data: [user1, user2], dataType: DataType.users)
        tableView = UITableView()
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: User.cellIdentifier())
        tableView.dataSource = dataSource
        tableView.reloadData()
        tableView.awakeFromNib()
    }
    
    func testDataSourceNumberOfItems() {
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2)
        XCTAssertEqual(dataSource.numberOfSectionsInTableView(tableView: tableView), 1)
    }
    
    func testDataSourceContent() {
        XCTAssertNil(dataSource.tableView(tableView, titleForHeaderInSection: 0))
        let userCell1 = dataSource.tableView(tableView, cellForRowAt: IndexPath(item: 0, section: 0)) as! UserCell
        let userCell2 = dataSource.tableView(tableView, cellForRowAt: IndexPath(item: 1, section: 0)) as! UserCell

        XCTAssertEqual(userCell1.nameLabel.text, "Ervin Howell")
        XCTAssertEqual(userCell1.addressLabel.text, "Victor Plains Suite 879, 90566-7771 Wisokyburgh")
        XCTAssertEqual(userCell1.emailLabel.text, "Shanna@melissa.tv")
        XCTAssertEqual(userCell1.usernameLabel.text, "Antonette")

        XCTAssertEqual(userCell2.nameLabel.text, "Horselover Fat")
        XCTAssertNil(userCell2.addressLabel.text)
        XCTAssertNil(userCell2.emailLabel.text)
        XCTAssertNil(userCell2.usernameLabel.text)
    }
    
    func testDataSourceReplaceContent() {
        let users = [StubLoader().userFromStub(), StubLoader().userFromStub(), StubLoader().userFromStub()]
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2)
        XCTAssertEqual(dataSource.numberOfSectionsInTableView(tableView: tableView), 1)
        
        dataSource.sections = [Section<User>(title: "A Title", cellData: users)]
        
        XCTAssertEqual(dataSource.tableView(tableView, titleForHeaderInSection: 0), "A Title")
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 3)
        XCTAssertEqual(dataSource.numberOfSectionsInTableView(tableView: tableView), 1)
        
        let userCell = dataSource.tableView(tableView, cellForRowAt: IndexPath(item: 2, section: 0)) as! UserCell
        XCTAssertEqual(userCell.nameLabel.text, "Ervin Howell")
        XCTAssertEqual(userCell.addressLabel.text, "Victor Plains Suite 879, 90566-7771 Wisokyburgh")
        XCTAssertEqual(userCell.emailLabel.text, "Shanna@melissa.tv")
        XCTAssertEqual(userCell.usernameLabel.text, "Antonette")
    }
}


