//
//  TableViewController.swift
//  InstagramAPI
//
//  Created by Admin on 02.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit
import Alamofire

enum RelationshipTableControllerType {
  case follows
  case followedBy
  case requestedBy
  case unknown
}

class RelationshipTableViewController: UITableViewController {

  var type: RelationshipTableControllerType = .unknown
  fileprivate var dataSource: [InstagramUser] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let relationshipTableViewModel = RelationshipTableViewModel.init(type: self.type)
        let request = relationshipTableViewModel.request()
        relationshipTableViewModel.getDataSource(request: request!, completion: {(dataSource: [InstagramUser]?) in
          if dataSource != nil {
            self.dataSource = dataSource!
            self.tableView.reloadData()
          }
        })
    }

}

extension RelationshipTableViewController {

  // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //swiftlint:disable:next line_length force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "RelationshipCell", for: indexPath) as! RelationshipCell
        let user = dataSource[indexPath.row]
        cell.fullNameLabel.text = user.fullName
        cell.userNameLabel.text = user.username
        cell.avatarImage.af_setImage(withURL: user.profilePictureUrl!)
        return cell
    }
}
