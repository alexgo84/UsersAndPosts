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
    
    let webService: WebService = WebService()
    
    func getAllUsers(completion: @escaping ([User]?, Error?) -> ()) {
        webService.load(resource: User.all) { users, error in
            completion(users, error)
        }
    }
    
    func getAllPosts(userId: NSNumber, completion: @escaping ([Post]?, Error?) -> ()) {
        webService.load(resource: Post.posts(userId: userId), completion: { (posts, error) in
            completion(posts, error)
        })
    }
}
