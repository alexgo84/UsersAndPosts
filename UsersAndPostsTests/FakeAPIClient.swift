//
//  FakeAPIClient.swift
//  UsersAndPostsTests
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import XCTest
@testable import UsersAndPosts

enum FakeError: Error {
    case fake
}

class FakeAPIClient: APIClient {
    
    public var fail = false
    
    override func getAllUsers(completion: @escaping ([User]?, Error?) -> ()) {

        if fail {
            completion(nil, FakeError.fake)
        } else {
            let user1 = StubLoader().userFromStub()
            let user2 = StubLoader().emptyUserFromStub()
            completion([user1, user2], nil)
        }
    }
    
    override func getAllPosts(userId: NSNumber, completion: @escaping ([Post]?, Error?) -> ()) {
        if fail {
            completion(nil, FakeError.fake)
        } else {
            let post = StubLoader().postFromStub()
            completion([post, post, post], nil)
        }
    }
}
