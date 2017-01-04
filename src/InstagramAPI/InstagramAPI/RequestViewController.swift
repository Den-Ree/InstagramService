//
//  RequestViewController.swift
//  InstagramAPI
//
//  Created by Sasha Kid on 12/25/16.
//  Copyright © 2016 ConceptOffice. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {
    var sectionsDataSource: [String?] = []
    var rowsDataSource: [[String?]] = []

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView.init(frame: .zero)
            tableView.estimatedRowHeight = 50
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Requests"
        sectionsDataSource = ["User", "Relationship", "Media", "Comment", "Like", "Tag", "Location"]
        rowsDataSource = [["Self", "Recent of self", "User id", "Recent of user-id", "Liked", "Search"], ["Follows", "Followed by", "Requested by", "Relationship"], ["Media id", "Shortcode", "Search id"], ["Comments", "Comment id"], ["Likes"], ["Tag name", "Tag name recent", "Search"], ["Location id", "Location id recent", "Search"]]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RequestViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsDataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsDataSource[section] as String!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RequestCell.self)) as! RequestCell
        cell.nameLabel.text = rowsDataSource[indexPath.section][indexPath.row]
        return cell
    }
}

extension RequestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
