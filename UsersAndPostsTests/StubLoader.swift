//
//  StubLoader.swift
//  UsersAndPostsTests
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
@testable import UsersAndPosts

struct StubLoader {
    func userFromStub() -> User {
        let userJSON = userJSONFromStub()
        let user = User(json: userJSON)!
        return user
    }
    
    func userJSONFromStub() -> JSONDict {
        let userStubURL = Bundle.main.url(forResource: "UserStub", withExtension: "json")
        let userData = try! Data(contentsOf: userStubURL!)
        return try! JSONSerialization.jsonObject(with: userData, options: []) as! JSONDict
    }
    
    func postFromStub() -> Post {
        let postJSON = postJSONFromStub()
        let post = Post(json: postJSON)
        return post!
    }
    
    func postJSONFromStub() -> JSONDict {
        let postStubURL = Bundle.main.url(forResource: "PostStub", withExtension: "json")
        let postData = try! Data(contentsOf: postStubURL!)
        return try! JSONSerialization.jsonObject(with: postData, options: []) as! JSONDict

    }
    
    func emptyUserFromStub() -> User {
        let userJSON = emptyUserJSONFromStub()
        let user = User(json: userJSON)!
        return user
    }
    
    func emptyUserJSONFromStub() -> JSONDict {
        let userStubURL = Bundle.main.url(forResource: "UserWithMissingInfoStub", withExtension: "json")
        let userData = try! Data(contentsOf: userStubURL!)
        return try! JSONSerialization.jsonObject(with: userData, options: []) as! JSONDict
    }
}
