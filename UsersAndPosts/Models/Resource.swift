//
//  Resource.swift
//  UsersAndPosts
//
//  Created by Alex Gordon on 30.09.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

typealias JSONDict = [String: AnyObject]

enum JSONURL {
    case users
    case posts(userId: String)
    
    func url() -> URL {
        switch self {
        case .users:
            return URL(string: "https://jsonplaceholder.typicode.com/users")!
        case .posts(let userId):
            return URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userId)")!
        }
    }
}

struct Resource<T> {
    let url: URL
    let parseFunction: (Data) -> T?
}

