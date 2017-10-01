//
//  Company.swift
//  UsersAndPosts
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

struct Company {
    let name: String
    let catchPhrase: String?
    let bs: String?
}

extension Company {
    init?(json: JSONDict) {
        guard let name = json["name"] as? String else {
                return nil
        }
        
        self.name = name
        self.catchPhrase = json["catchPhrase"] as? String
        self.bs = json["bs"] as? String
    }
}
