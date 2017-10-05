//
//  User.swift
//  UsersAndPosts
//
//  Created by Alex Gordon on 30.09.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

struct User: Identifiable {
    let id: NSNumber
    let name: String?
    let username: String?
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?
    
    static func cellIdentifier() -> String {
        return "UserCell"
    }
}

extension User {

    init?(json: JSONDict) {
        guard let id = json["id"] as? NSNumber else {
            return nil
        }
        
        self.id = id
        self.name = json["name"] as? String
        self.username = json["username"] as? String
        self.email = json["email"] as? String
        self.phone = json["phone"] as? String
        self.website = json["website"] as? String
        
        let addressJson = json["address"] as? JSONDict
        let companyJson = json["company"] as? JSONDict

        if let companyJson = companyJson {
            self.company = Company(json: companyJson)
        } else {
            self.company = nil
        }

        if let addressJson = addressJson {
            self.address = Address(json: addressJson)
        } else {
            self.address = nil
        }
    }
}

extension User {
    static let all = Resource<[User]>(url: JSONURL.users.url()) { data in
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        let arrayOfJson = json as? [JSONDict]
        return arrayOfJson?.flatMap(User.init)
    }
}

