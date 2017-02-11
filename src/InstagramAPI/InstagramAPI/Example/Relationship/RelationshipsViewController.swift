//
//  RelationshipsViewController.swift
//  InstagramAPI
//
//  Created by Sasha Kid on 2/11/17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit
import AlamofireImage

class RelationshipsViewController: UIViewController {
    
    enum RelationshipType: Int {
        case follows
        case followedBy
        case requestedBy
        case relationship
        case unknown
    }
    var type: RelationshipType = .unknown
    
    @IBOutlet fileprivate weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView.init(frame: .zero)
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    fileprivate var dataSource: [InstagramUser?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var request: InstagramRequestProtocol
        
        switch type {
        case .follows:
            request = Instagram.RelationshipEnpoint.Get.follows
        case .followedBy:
            request = Instagram.RelationshipEnpoint.Get.followedBy
        case .requestedBy:
            request = Instagram.RelationshipEnpoint.Get.requestedBy
        case .relationship:
            request = Instagram.RelationshipEnpoint.Get.relationship(userId: "")
            //TODO: fix
        case .unknown:
            request = Instagram.RelationshipEnpoint.Get.follows
        }
        
        InstagramManager.shared.networkClient.send(request, completion: { (users: InstagramArrayResponse<InstagramUser>?, error: Error?) in
            guard let users = users?.data else {
                return
            }
            self.dataSource = users
            self.tableView.reloadData()
        })
    }
}

extension RelationshipsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RelationshipsCell") as! RelationshipsCell;
        let currentUser = dataSource[indexPath.row]
        cell.usernameLabel.text = currentUser?.username
        cell.fullnameLabel.text = currentUser?.fullName
        cell.avatarImageView.af_setImage(withURL: (currentUser?.profilePictureURL)!)
        
        return cell;
    }
}

extension RelationshipsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentUser = dataSource[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
        controller.userID = currentUser?.objectId
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
