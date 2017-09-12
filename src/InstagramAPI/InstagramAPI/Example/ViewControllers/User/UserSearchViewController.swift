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
    fileprivate var dataSource: [InstagramUser?] = []
    fileprivate var searchActive: Bool = false

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
        //swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserSearchCell") as! UserSearchCell
        let currentUser = dataSource[indexPath.row]
        cell.usernameLabel.text = currentUser?.username
        cell.fullnameLabel.text = currentUser?.fullName
        cell.avatarImageView.af_setImage(withURL: (currentUser?.profilePictureUrl)!)

        return cell
    }
}

extension UserSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentUser = dataSource[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //swiftlint:disable:next force_cast line_length
        let controller = storyboard.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
        controller.userParameter = InstagramUserRouter.UserParameter.id((currentUser?.id)!)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension UserSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let userSearchRouter = InstagramUserRouter.getSearch(.init(query: searchText, count: 10))
        //swiftlint:disable:next line_length
        InstagramClient().send(userSearchRouter, completion: { (users: InstagramArrayResponse<InstagramUser>?, _: Error?) in
         guard let users = users?.data else {
                return
            }
            self.dataSource = users
            self.tableView.reloadData()
        })
    }
}
