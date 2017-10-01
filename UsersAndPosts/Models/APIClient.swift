//
//  APIClient.swift
//  UsersAndPosts
//
//  Created by Alex Gordon on 30.09.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

// Not 'final' for testing
class APIClient: NSObject {
    func getAllUsers(completion: @escaping ([User]?, Error?) -> ()) {
        WebService().load(resource: User.all) { users, error in
            completion(users, error)
        }
    }
    
    func getAllPosts(userId: NSNumber, completion: @escaping ([Post]?, Error?) -> ()) {
        WebService().load(resource: Post.posts(userId: userId), completion: { (posts, error) in
            completion(posts, error)
        })
    }
}
