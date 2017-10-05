//
//  WebServiceTests.swift
//  UsersAndPostsTests
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
@testable import UsersAndPosts

class WebServiceTests: XCTestCase {
    
    func testWebServiceUsers() {
        
        let userResource = Resource<[User]>(url: JSONURL.users.url()) { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            let arrayOfJson = json as? [JSONDict]
            return arrayOfJson?.flatMap(User.init)
        }

        let webService = WebService()
        var expectedUsers: [User]?

        let usersLoadedExpectation = XCTestExpectation(description: "usersLoaded")

        webService.load(resource: userResource) { (users, error) in
            expectedUsers = users
            usersLoadedExpectation.fulfill()
        }
        
        wait(for: [usersLoadedExpectation], timeout: 10.0)
        guard let users = expectedUsers else {
            XCTFail()
            return
        }
        
        XCTAssert(users.count > 0)
    }
    
    func testWebServicePosts() {
        let postResource = Resource<[Post]>(url: JSONURL.posts(userId: "1").url()) { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            let arrayOfJson = json as? [JSONDict]
            return arrayOfJson?.flatMap(Post.init)
        }
        
        let webService = WebService()
        var expectedPosts: [Post]?
        
        let postsLoadedExpectation = XCTestExpectation(description: "postsLoaded")
        
        webService.load(resource: postResource) { (posts, error) in
            expectedPosts = posts
            postsLoadedExpectation.fulfill()
        }
        
        wait(for: [postsLoadedExpectation], timeout: 10.0)
        guard let posts = expectedPosts else {
            XCTFail()
            return
        }
        
        XCTAssert(posts.count > 0)
    }
    
    func testAllUsers() {

        let expectation = XCTestExpectation(description: "allUsersLoaded")
        var expectedUsers: [User]?

        WebService().load(resource: User.all) { users, error in
            expectedUsers = users
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedUsers?.count, 10)
    }
}
