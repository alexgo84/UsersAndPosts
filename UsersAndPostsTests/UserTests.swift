//
//  UserTests.swift
//  UsersAndPostsTests
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
@testable import UsersAndPosts

class UserTests: XCTestCase {
    
    var userJSON: JSONDict?

    override func setUp() {
        super.setUp()
        userJSON = StubLoader().userJSONFromStub()
    }

    func testUserDeserialization() {
        guard let userJSON = userJSON else {
            XCTFail()
            return
        }
        
        guard let user = User(json: userJSON) else {
            XCTFail()
            return
        }
        
        XCTAssertNotNil(user)
        
        // User details
        XCTAssertEqual(user.id, NSNumber(value: 2))
        XCTAssertEqual(user.name, "Ervin Howell")
        XCTAssertEqual(user.email, "Shanna@melissa.tv")
        XCTAssertEqual(user.username, "Antonette")
        XCTAssertEqual(user.phone, "010-692-6593 x09125")
        XCTAssertEqual(user.website, "anastasia.net")
        
        // Address details
        XCTAssertEqual(user.address?.city, "Wisokyburgh")
        XCTAssertEqual(user.address?.street, "Victor Plains")
        XCTAssertEqual(user.address?.suite, "Suite 879")
        XCTAssertEqual(user.address?.zipcode, "90566-7771")
        XCTAssertEqual(user.address?.geo?.lat, "-43.9509")
        XCTAssertEqual(user.address?.geo?.lng, "-34.4618")
        
        // Company details
        XCTAssertEqual(user.company?.name, "Deckow-Crist")
        XCTAssertEqual(user.company?.catchPhrase, "Proactive didactic contingency")
        XCTAssertEqual(user.company?.bs, "synergize scalable supply-chains")
    }
}
