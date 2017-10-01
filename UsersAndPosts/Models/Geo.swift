//
//  Geo.swift
//  UsersAndPosts
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

struct Geo {
    let lat: String
    let lng: String
}

extension Geo {
    init?(json: JSONDict) {
        guard let lat = json["lat"] as? String,
            let lng = json["lng"] as? String else {
                return nil
        }
        self.lat = lat
        self.lng = lng
    }
}
