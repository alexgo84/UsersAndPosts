//
//  WebService.swift
//  UsersAndPosts
//
//  Created by Alex Gordon on 30.09.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation

final class WebService {
    func load<A>(resource: Resource<A>, completion: @escaping (A?, Error?) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let parsedData = resource.parseFunction(data)
            completion(parsedData, nil)
        }.resume()
    }
}

