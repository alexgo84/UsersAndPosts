//
//  ResourceTests.swift
//  UsersAndPostsTests
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
@testable import UsersAndPosts

class ResourceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    func testUserResource() {
        let resource = Resource<[User]>(url: JSONURL.users.rawValue) { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            let arrayOfJson = json as? [JSONDict]
            return arrayOfJson?.flatMap(User.init)
        }
        
        XCTAssert(resource.url.absoluteString == "https://jsonplaceholder.typicode.com/users")
    }
    
    func testPostResource() {
        let resource = Resource<[Post]>(url: JSONURL.posts(userId: "1").rawValue) { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            let arrayOfJson = json as? [JSONDict]
            return arrayOfJson?.flatMap(Post.init)
        }
        
        XCTAssert(resource.url.absoluteString == "https://jsonplaceholder.typicode.com/posts?userId=1")
    }
}
