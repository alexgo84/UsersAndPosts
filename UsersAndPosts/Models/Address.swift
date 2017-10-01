//
//  Address.swift
//  UsersAndPosts
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

struct Address {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo?
}

extension Address {
    init?(json: JSONDict) {
        guard let street = json["street"] as? String,
            let suite = json["suite"] as? String,
            let city = json["city"] as? String,
            let zipcode = json["zipcode"] as? String else {
                return nil
        }
        
        let geoJson = json["geo"] as? JSONDict
        if let geoJson = geoJson {
            self.geo = Geo(json: geoJson)
        } else {
            self.geo = nil
        }
        
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
    }
}

extension Address {
    func descriptionString() -> String {
        return street + " " + String(suite) + ", " + zipcode + " " + city
    }
}
