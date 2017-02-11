//
//  RequestViewController.swift
//  InstagramAPI
//
//  Created by Sasha Kid on 12/25/16.
//  Copyright © 2016 ConceptOffice. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {
    fileprivate var sectionsDataSource: [String?] = []
    fileprivate var rowsDataSource: [[String?]] = []

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
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            //User
            
            switch indexPath.row {
            case 0:
                //Self
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
                controller.title = rowsDataSource[indexPath.section][indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)
                
                break
            case 1:
                //Recent of self
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "UserMediaViewController") as! UserMediaViewController
                controller.type = .recent(nil)
                controller.title = rowsDataSource[indexPath.section][indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)

                break
            case 2:
                //User id
                
                let alertController = UIAlertController(title: "Enter user-id", message: "", preferredStyle: .alert)
                
                let goAction = UIAlertAction(title: "Go", style: .default, handler: {alert -> Void in
                    let firstTextField = alertController.textFields![0] as UITextField
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
                    controller.userID = firstTextField.text
                    controller.title = self.rowsDataSource[indexPath.section][indexPath.row]
                    self.navigationController?.pushViewController(controller, animated: true)
                })
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(action : UIAlertAction!) -> Void in
                    
                })
                alertController.addTextField { (textField : UITextField!) -> Void in
                    textField.placeholder = "user-id"
                }
                alertController.addAction(goAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                
                break
            case 3:
                //Recent of user-id
                let alertController = UIAlertController(title: "Enter user-id", message: "", preferredStyle: .alert)
                
                let goAction = UIAlertAction(title: "Go", style: .default, handler: {alert -> Void in
                    let firstTextField = alertController.textFields![0] as UITextField
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "UserMediaViewController") as! UserMediaViewController
                    controller.type = .recent(firstTextField.text)
                    controller.title = self.rowsDataSource[indexPath.section][indexPath.row]
                    self.navigationController?.pushViewController(controller, animated: true)
                })
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(action : UIAlertAction!) -> Void in
                    
                })
                alertController.addTextField { (textField : UITextField!) -> Void in
                    textField.placeholder = "user-id"
                }
                alertController.addAction(goAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                
                break
            case 4:
                //Liked
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "UserMediaViewController") as! UserMediaViewController
                controller.type = .liked
                controller.title = rowsDataSource[indexPath.section][indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)
                
                break
            case 5:
                //Search
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "UserSearchViewController") as! UserSearchViewController
                controller.title = rowsDataSource[indexPath.section][indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)

                break
                
            default:
                break
                
            }
            break
            
        case 1:
            //Relationship
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "RelationshipsViewController") as! RelationshipsViewController
            controller.title = rowsDataSource[indexPath.section][indexPath.row]
            controller.type = RelationshipsViewController.RelationshipType(rawValue: indexPath.row)!
            self.navigationController?.pushViewController(controller, animated: true)

        case 2:
            //Media
            
            break
        case 3:
            //Comment
            
            break
        case 4:
            //Like
            
            break
        case 5:
            //Tag
            
            break
        case 6:
            //Location
            
            break
            
        default:
            break
            
        }
    }
}
