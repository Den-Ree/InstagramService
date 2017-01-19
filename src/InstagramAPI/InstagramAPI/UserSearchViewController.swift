//
//  UserSearchViewController.swift
//  InstagramAPI
//
//  Created by Yakovlev, Alexander on 1/10/17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController {
    
    @IBOutlet fileprivate weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView.init(frame: .zero)
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }

    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    fileprivate var dataSource: [InstagramUser?] = []
    fileprivate var searchActive : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension UserSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserSearchCell") as! UserSearchCell;
        let currentUser = dataSource[indexPath.row]
        cell.usernameLabel.text = currentUser?.username
        return cell;
    }
}

extension UserSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        InstagramManager.shared.userService.fetchUsers(searchText: searchText) { (users, error) in
            guard let users = users else {
                return
            }
            self.dataSource = users
            self.tableView.reloadData()
        }
    }
}
