//
//  Post.swift
//  UsersAndPosts
//
//  Created by Alex Gordon on 30.09.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation


struct Post: Identifiable {

    
    let userId: NSNumber
    let id: NSNumber
    let title: String
    let body: String
    
    static func cellIdentifier() -> String {
        return "PostCell"
    }
    
    static func name() -> String {
        return "Posts"
    }
}

extension Post {
    
    init?(json: JSONDict) {
    
        guard let userId = json["userId"] as? NSNumber,
            let id = json["id"] as? NSNumber,
            let title = json["title"] as? String,
            let body = json["body"] as? String else {
                return nil
        }
        
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}

extension Post {
    static func posts(userId: NSNumber) -> Resource<[Post]> {
        let userIdString = String(describing: userId)
        return Resource<[Post]>(url: JSONURL.posts(userId: userIdString).url()) { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            let arrayOfJson = json as? [JSONDict]
            return arrayOfJson?.flatMap(Post.init)
        }
    }
}
