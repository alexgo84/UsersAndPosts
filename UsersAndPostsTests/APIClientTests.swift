//
//  APIClientTests.swift
//  UsersAndPostsTests
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
@testable import UsersAndPosts

class APIClientTests: XCTestCase {
    
    let apiClient = APIClient()
    
    func testAPIClientUsers() {
        
        var expectedUsers: [User]?
        let expectation = XCTestExpectation(description: "users from APIClient")
        apiClient.getAllUsers { (users, error) in
            expectedUsers = users
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
        
        guard let users = expectedUsers else {
            XCTFail()
            return
        }
        
        XCTAssert(users.count > 0)
    }
    
    func testAPIClientPosts() {
        
        var expectedPosts: [Post]?
        let expectation = XCTestExpectation(description: "posts from APIClient")
        apiClient.getAllPosts(userId: 1) { (posts, error) in
            expectedPosts = posts
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
        
        guard let posts = expectedPosts else {
            XCTFail()
            return
        }
        
        XCTAssert(posts.count > 0)
    }
}

