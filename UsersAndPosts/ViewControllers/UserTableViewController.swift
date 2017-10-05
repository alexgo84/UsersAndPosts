//
//  UserTableViewController.swift
//  UsersAndPosts
//
//  Created by Alex Gordon on 30.09.17.
//  Copyright © 2017 Alex Gordon. All rights reserved.
//

import UIKit


class UserTableViewController: UITableViewController {

    let kShowPostsSegueIdentifier: String = "ShowPosts"

    // Public for testing
    public var apiClient: APIClient!
    
    let dataSource = DataSource<User>()
    var postTableViewController: PostTableViewController? = nil

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: User.cellIdentifier())
        self.tableView.dataSource = dataSource
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            postTableViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? PostTableViewController
            postTableViewController?.apiClient = apiClient
            postTableViewController?.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            postTableViewController?.navigationItem.leftItemsSupplementBackButton = true
        }
        
        fetchUsersAsync()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    // MARK: <UITableViewController>
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = dataSource.sections[0].cellData[indexPath.row]
        if let postTableViewController = postTableViewController {
            postTableViewController.clearData()
            postTableViewController.fetchPostsAsync(for: user)
            splitViewController?.showDetailViewController(postTableViewController, sender: nil)
        }
    }

    //MARK: - Private methods
    
    private func fetchUsersAsync() {
        apiClient.getAllUsers { [weak self] (users, error) in
            guard error == nil else {
                self?.show(message: error!.localizedDescription)
                return
            }

            if let users = users {
                self?.dataSource.sections = [Section<User>(title: nil, cellData: users)]
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }            }
            else {
                self?.show(message: "We are sorry, an unknown error has happened. Please try again later or call support.",
                           title: "Oops...")
                assert(false)
            }
        }
    }
    
    private func show(message: String, title: String = "Error") {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Try Again", style: .default) { [weak self] (action) in
            self?.fetchUsersAsync()
        }
        alert.addAction(action)

        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}


