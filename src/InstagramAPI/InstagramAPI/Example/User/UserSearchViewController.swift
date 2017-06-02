//
//  UserSearchViewController.swift
//  InstagramAPI
//
//  Created by Yakovlev, Alexander on 1/10/17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit
import AlamofireImage

class UserSearchViewController: UIViewController {
    
    @IBOutlet fileprivate weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView.init(frame: .zero)
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }

    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    fileprivate var dataSource: [Instagram.User?] = []
    fileprivate var searchActive : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Search"
    }

}

extension UserSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserSearchCell") as! UserSearchCell;
        let currentUser = dataSource[indexPath.row]
        cell.usernameLabel.text = currentUser?.username
        cell.fullnameLabel.text = currentUser?.fullName
        cell.avatarImageView.af_setImage(withURL: (currentUser?.profilePictureURL)!)
            
        return cell;
    }
}

extension UserSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentUser = dataSource[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
        controller.userID = currentUser?.objectId
        self.navigationController?.pushViewController(controller, animated: true)
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
        let searchParams = Instagram.UsersEndpoint.Parameter.SearchUser(query: searchText, count: 10)
        let request = Instagram.UsersEndpoint.Get.search(searchParams)
        InstagramManager.shared.networkClient.send(request, completion: { (users: InstagramArrayResponse<Instagram.User>?, error: Error?) in
            guard let users = users?.data else {
                return
            }
            self.dataSource = users
            self.tableView.reloadData()
        })
    }
}
