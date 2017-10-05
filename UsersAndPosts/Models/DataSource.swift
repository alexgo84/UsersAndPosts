//
//  DataSource.swift
//  UsersAndPosts
//
//  Created by Alex Gordon on 01.10.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import Foundation
import UIKit

public protocol Identifiable {
    static func cellIdentifier() -> String
}

struct Section <T: Identifiable>{
    public var title: String?
    public let cellData: [T]
    
    init(title: String?, cellData: [T]) {
        self.title = title
        self.cellData = cellData
    }
}


class DataSource<T: Identifiable>: NSObject, UITableViewDataSource {
    public var sections: [Section<T>] {
        didSet {
            if sections.count == 0 {
                fatalError("Cannot set less than one section")
            }
        }
    }
    
    init(data: [T] = []) {
        guard T.self == User.self || T.self == Post.self else {
            fatalError("Data source for type \(T.self) is not supported!")
        }
        
        self.sections = [Section<T>(title: nil, cellData: data)]
        super.init()
    }
    
    public func clearData() {
        sections = [Section<T>(title: nil, cellData: [])]
    }
    
    //MARK: - <UITableViewDataSource>
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cellData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: T.cellIdentifier()) else {
            fatalError("Unknown Identifier")
        }

        let cellData: T = sections[indexPath.section].cellData[indexPath.row]

        switch T.cellIdentifier() {
        case User.cellIdentifier():
            UserCellConfigurator(user: cellData as! User).configure(cell: cell as! UserCell)
        case Post.cellIdentifier():
            PostCellConfigurator(post: cellData as! Post).configure(cell: cell as! PostCell)
        default:
            fatalError("Unknown identifier \(T.cellIdentifier())")
        }
        
        return cell
    }
}
