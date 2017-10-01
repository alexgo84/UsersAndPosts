//
//  PostCellConfigurator.swift
//  UsersAndPosts
//
//  Created by Alex Gordon on 30.09.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation
import UIKit

struct PostCellConfigurator {
    let post: Post
    
    func configure(cell: PostCell) {
        cell.titleLabel.text = post.title
        cell.bodyLabel.text = post.body
        cell.layoutSubviews()
    }
}
