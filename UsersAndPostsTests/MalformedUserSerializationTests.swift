//
//  MalformedUserSerializationTests.swift
//  UsersAndPostsTests
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
@testable import UsersAndPosts

class MalformedUserSerializationTests: XCTestCase {

    var userJSON: JSONDict?

    override func setUp() {
        super.setUp()
        userJSON = StubLoader().emptyUserJSONFromStub()
    }
    
    func testUserWithMissingInfoSerialization() {
        guard let userJSON = userJSON else {
            XCTFail()
            return
        }
        
        guard let user = User(json: userJSON) else {
            XCTFail()
            return
        }
        
        // User details
        XCTAssertNotNil(user)
        XCTAssertEqual(user.id, NSNumber(value: 20))
        XCTAssertEqual(user.name, "Horselover Fat")
    }
}

