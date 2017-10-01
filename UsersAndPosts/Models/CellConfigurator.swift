//
//  Configurator.swift
//  UsersAndPosts
//
//  Created by Alex Gordon on 30.09.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation
import UIKit

protocol CellConfigurator {
    func configure(cell: UserCell)
}

struct UserCellConfigurator {
    let user: User
    
    func configure(cell: UserCell) {
        cell.nameLabel.text = user.name
        cell.usernameLabel.text = user.username
        cell.emailLabel.text = user.email
        cell.addressLabel.text = user.address?.descriptionString()
        cell.layoutSubviews()
    }
}

struct PostCellConfigurator {
    let post: Post
    
    func configure(cell: PostCell) {
        cell.titleLabel.text = post.title
        cell.bodyLabel.text = post.body
        cell.layoutSubviews()
    }
}
