//
//  PostTests.swift
//  UsersAndPostsTests
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
@testable import UsersAndPosts


class PostTests: XCTestCase {
    
    var postJSON: JSONDict?

    override func setUp() {
        super.setUp()
        postJSON = StubLoader().postJSONFromStub()
    }

    func testPostDeserialization() {
        guard let postJSON = postJSON else {
            XCTFail()
            return
        }
        
        guard let post = Post(json: postJSON) else {
            XCTFail()
            return
        }
        
        XCTAssertNotNil(post)

        XCTAssertEqual(post.id, NSNumber(value: 12))
        XCTAssertEqual(post.userId, NSNumber(value: 2))
        XCTAssertEqual(post.title, "in quibusdam tempore odit est dolorem")
        XCTAssertEqual(post.body, "itaque id aut magnam\npraesentium quia et ea odit et ea voluptas et\nsapiente quia nihil amet occaecati quia id voluptatem\nincidunt ea est distinctio odio")
    }
}

