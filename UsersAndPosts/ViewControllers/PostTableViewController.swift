//
//  PostTableViewController.swift
//  UsersAndPosts
//
//  Created by Alex Gordon on 30.09.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import UIKit

class PostTableViewController: UITableViewController {
    
    var apiClient: APIClient?
    let dataSource = DataSource<Post>()
    var user: User!

    // MARK: - Public Methods
    
    public func fetchPostsAsync(for user: User) {
        self.user = user
        fetchPostsAsync()
    }
    
    public func clearData() {
        dataSource.clearData()
        tableView.reloadData()
    }
    
    // MARK: - <UIViewController>
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: Post.cellIdentifier())
        tableView.dataSource = dataSource
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private Methods
    
    private func fetchPostsAsync() {
        guard let user = user, let apiClient = apiClient else {
            fatalError("User and APIClient must be set")
        }
        
        if let username = user.username {
            self.title = "Posts by \(username)"
        } else {
            self.title = nil
        }
        
        apiClient.getAllPosts(userId: user.id, completion: { [weak self] (posts, error) in
            
            guard error == nil else {
                self?.show(message: error!.localizedDescription)
                return
            }
            
            if let posts = posts {
                self?.dataSource.sections = [Section<Post>(title: nil, cellData: posts)]
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                self?.show(message: "We are sorry, an unknown error has happened. Please try again later or call support.",
                       title: "Oops...")
                assert(false)
            }
        })
    }
    
    private func show(message: String, title: String = "Error") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { action in
            self.navigationController?.popToRootViewController(animated: true)
        }))

        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

