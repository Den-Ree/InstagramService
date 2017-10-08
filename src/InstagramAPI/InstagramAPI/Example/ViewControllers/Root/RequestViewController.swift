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
        //swiftlint:disable:next line_length
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
        //swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RequestCell.self)) as! RequestCell
        cell.nameLabel.text = rowsDataSource[indexPath.section][indexPath.row]
        return cell
    }
}

extension RequestViewController: UITableViewDelegate {
    //swiftlint:disable:next cyclomatic_complexity function_body_length
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // TODO: Fix spagetti
        switch indexPath.section {
        case 0:
            //User

            switch indexPath.row {
            case 0:
                //Self
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //swiftlint:disable:next force_cast line_length
                if let controller = storyboard.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController {
                  controller.userParameter = .owner
                  controller.title = rowsDataSource[indexPath.section][indexPath.row]
                  self.navigationController?.pushViewController(controller, animated: true)
                }
                break
            case 1:
                //Recent of self
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //swiftlint:disable:next force_cast line_length
                if let controller = storyboard.instantiateViewController(withIdentifier: "UserMediaViewController") as? UserMediaViewController {
                  controller.type = .recent(nil)
                  controller.title = rowsDataSource[indexPath.section][indexPath.row]
                  self.navigationController?.pushViewController(controller, animated: true)
                }
                break
            case 2:
                //User id

                let alertController = UIAlertController(title: "Enter user-id", message: "", preferredStyle: .alert)

                let goAction = UIAlertAction(title: "Go", style: .default, handler: {_ -> Void in
                    let firstTextField = alertController.textFields![0] as UITextField
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    //swiftlint:disable:next force_cast line_length
                    if let controller = storyboard.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController {
                      controller.userParameter = InstagramUserRouter.UserParameter.id(firstTextField.text!)
                      controller.title = self.rowsDataSource[indexPath.section][indexPath.row]
                      self.navigationController?.pushViewController(controller, animated: true)
                    }
                })
                //swiftlint:disable:next line_length
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ : UIAlertAction!) -> Void in

                })
                alertController.addTextField { (textField: UITextField!) -> Void in
                    textField.placeholder = "user-id"
                }
                alertController.addAction(goAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)

                break
            case 3:
                //Recent of user-id
                let alertController = UIAlertController(title: "Enter user-id", message: "", preferredStyle: .alert)

                let goAction = UIAlertAction(title: "Go", style: .default, handler: {_ -> Void in
                    let firstTextField = alertController.textFields![0] as UITextField
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    //swiftlint:disable:next force_cast line_length
                    let controller = storyboard.instantiateViewController(withIdentifier: "UserMediaViewController") as! UserMediaViewController
                    controller.type = .recent(firstTextField.text)
                    controller.title = self.rowsDataSource[indexPath.section][indexPath.row]
                    self.navigationController?.pushViewController(controller, animated: true)
                })
                //swiftlint:disable:next line_length
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ : UIAlertAction!) -> Void in

                })
                alertController.addTextField { (textField: UITextField!) -> Void in
                    textField.placeholder = "user-id"
                }
                alertController.addAction(goAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)

                break
            case 4:
                //Liked
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //swiftlint:disable:next force_cast line_length
                let controller = storyboard.instantiateViewController(withIdentifier: "UserMediaViewController") as! UserMediaViewController
                controller.type = .liked
                controller.title = rowsDataSource[indexPath.section][indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)

                break
            case 5:
                //Search
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //swiftlint:disable:next force_cast line_length
                let controller = storyboard.instantiateViewController(withIdentifier: "UserSearchViewController") as! UserSearchViewController
                controller.title = rowsDataSource[indexPath.section][indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)

                break

            default:
                break

            }
            break

        case 1:
            // Relationship
            switch indexPath.row {
            case 0:
                //Follows
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //swiftlint:disable:next force_cast line_length
                let controller = storyboard.instantiateViewController(withIdentifier:   "RelationshipTableViewController") as! RelationshipTableViewController
                controller.type = .follows
                controller.title = rowsDataSource[indexPath.section][indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)
                break
            case 1:
              // Followed by
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //swiftlint:disable:next force_cast line_length
                let controller = storyboard.instantiateViewController(withIdentifier: "RelationshipTableViewController") as! RelationshipTableViewController
                controller.type = .followedBy
                controller.title = rowsDataSource[indexPath.section][indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)
                break
            case 2:
                //Requested by
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //swiftlint:disable:next force_cast line_length
                let controller = storyboard.instantiateViewController(withIdentifier:   "RelationshipTableViewController") as! RelationshipTableViewController
                controller.type = .requestedBy
                controller.title = rowsDataSource[indexPath.section][indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)
                break
            case 3:
                // Relationship

                let alertController = UIAlertController.init(title: "TargetUserId", message: "", preferredStyle: .alert)

                let goAction = UIAlertAction.init(title: "Go", style: .default, handler: {_ -> Void in
                  let firstTextField = alertController.textFields?[0]
                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  //swiftlint:disable:next force_cast line_length
                  let controller = storyboard.instantiateViewController(withIdentifier:"RelationshipViewController") as! RelationshipViewController
                  controller.targetUserId = firstTextField?.text
                  controller.title = self.rowsDataSource[indexPath.section][indexPath.row]
                  self.navigationController?.pushViewController(controller, animated: true)
                  })
                //swiftlint:disable:next line_length
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ : UIAlertAction!) -> Void in

                })
                alertController.addTextField { (textField: UITextField!) -> Void in
                  textField.placeholder = "Target_user-id"
                }
                alertController.addAction(goAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                break
          default:
            break
          }
            break
        case 2:
            //Media
            switch indexPath.row {
            case 0:
                //Media Id
                let alertController = UIAlertController.init(title: "MediaId", message: "", preferredStyle: .alert)

                let goAction = UIAlertAction.init(title: "Go", style: .default, handler: { _ -> Void in
                  let firstTextField = alertController.textFields?[0]
                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  //swiftlint:disable:next force_cast line_length
                  let controller = storyboard.instantiateViewController(withIdentifier: "MediaViewController") as! MediaViewController
                  controller.mediaParameter = InstagramMediaRouter.MediaParameter.id((firstTextField?.text)!)
                  controller.title = self.rowsDataSource[indexPath.section][indexPath.row]
                  self.navigationController?.pushViewController(controller, animated: true)
                })
                //swiftlint:disable:next line_length
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ : UIAlertAction!) -> Void in
                })

                alertController.addTextField { (textField: UITextField!) -> Void in
                  textField.placeholder = "media_id"
                }
                alertController.addAction(goAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)

            case 1:
              //Media Id with ShortCode
                //swiftlint:disable:next line_length
                let alertController = UIAlertController.init(title: "MediaIdShortCode", message: "", preferredStyle: .alert)

                let goAction = UIAlertAction.init(title: "Go", style: .default, handler: { _ -> Void in
                  let firstTextField = alertController.textFields?[0]
                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  //swiftlint:disable:next force_cast line_length
                  let controller = storyboard.instantiateViewController(withIdentifier: "MediaViewController") as! MediaViewController
                  controller.mediaParameter = InstagramMediaRouter.MediaParameter.shortcode((firstTextField?.text)!)
                  controller.title = self.rowsDataSource[indexPath.section][indexPath.row]
                  self.navigationController?.pushViewController(controller, animated: true)
                })
                //swiftlint:disable:next line_length
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ : UIAlertAction!) -> Void in
                })

                alertController.addTextField { (textField: UITextField!) -> Void in
                  textField.placeholder = "media id shortcode"
                }
                alertController.addAction(goAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)

                break

            case 2:
              //Media Search
                //swiftlint:disable:next line_length
                let alertController = UIAlertController.init(title: "MediaSearchId", message: "", preferredStyle: .alert)

                let goAction = UIAlertAction.init(title: "Go", style: .default, handler: { _ -> Void in
                  let longitudeTextField = alertController.textFields?[0]
                  let latitudeTextField = alertController.textFields?[1]
                  let distanceTextField = alertController.textFields?[2]
                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  //swiftlint:disable:next force_cast line_length
                  let controller = storyboard.instantiateViewController(withIdentifier: "MediaSearchViewController") as!  MediaSearchViewController
                  //swiftlint:disable:next line_length
                  controller.parameter = InstagramMediaRouter.SearchMediaParameter(longitude: Double((longitudeTextField?.text)!)!, latitude: Double((latitudeTextField?.text)!)!, distance: Double((distanceTextField?.text)!))

                  controller.title = self.rowsDataSource[indexPath.section][indexPath.row]
                  self.navigationController?.pushViewController(controller, animated: true)
                })
                //swiftlint:disable:next line_length
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ : UIAlertAction!) -> Void in
                })

                alertController.addTextField { (textField: UITextField!) -> Void in
                  textField.placeholder = "longitude"
                }
                alertController.addTextField { (textField: UITextField!) -> Void in
                  textField.placeholder = "latitude"
                }
                alertController.addTextField { (textField: UITextField!) -> Void in
                  textField.placeholder = "distance"
                }
                alertController.addAction(goAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                break
            default:
              break
            }
            break
        case 3:
            //Comment
          switch indexPath.row {
            case 0:
              // Comments
              let alertController = UIAlertController.init(title: "MediaId", message: "", preferredStyle: .alert)

              let goAction = UIAlertAction.init(title: "Go", style: .default, handler: { _ -> Void in
                let firstTextField = alertController.textFields?[0]
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //swiftlint:disable:next force_cast line_length
                let controller = storyboard.instantiateViewController(withIdentifier: "CommentTableViewController") as! CommentTableViewController
                controller.mediaId = firstTextField?.text
                controller.title = self.rowsDataSource[indexPath.section][indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)
              })
              //swiftlint:disable:next line_length
              let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ : UIAlertAction!) -> Void in
              })

              alertController.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "media_id"
              }
              alertController.addAction(goAction)
              alertController.addAction(cancelAction)
              self.present(alertController, animated: true, completion: nil)

              break
            case 1:
                // CommentId
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              //swiftlint:disable:next force_cast line_length
              let controller = storyboard.instantiateViewController(withIdentifier: "CommentIdViewController") as! CommentIdViewController
              self.navigationController?.pushViewController(controller, animated: true)
              controller.title = rowsDataSource[indexPath.section][indexPath.row]
              break
            default:
              break
            }
            break
        case 4:
            //Like
          switch indexPath.row {
            case 0:
              let alertController = UIAlertController.init(title: "MediaId", message: "", preferredStyle: .alert)

              let goAction = UIAlertAction.init(title: "Go", style: .default, handler: { _ -> Void in
                let firstTextField = alertController.textFields?[0]
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //swiftlint:disable:next force_cast line_length
                let controller = storyboard.instantiateViewController(withIdentifier: "LikeViewController") as! LikeViewController
                controller.mediaId = firstTextField?.text
                controller.title = self.rowsDataSource[indexPath.section][indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)
              })
              //swiftlint:disable:next line_length
              let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ : UIAlertAction!) -> Void in
              })

              alertController.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "media_id"
              }
              alertController.addAction(goAction)
              alertController.addAction(cancelAction)
              self.present(alertController, animated: true, completion: nil)
            default:
              break
          }

            break
        case 5:
            //Tag
          switch indexPath.row {
            case 0:
              // Tags Name
              let alertController = UIAlertController.init(title: "TagName", message: "", preferredStyle: .alert)

              let goAction = UIAlertAction.init(title: "Go", style: .default, handler: { _ -> Void in
                let firstTextField = alertController.textFields?[0]
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //swiftlint:disable:next force_cast line_length
                let controller = storyboard.instantiateViewController(withIdentifier: "TagNameViewController") as! TagNameViewController
                controller.tagName = firstTextField?.text
                controller.title = self.rowsDataSource[indexPath.section][indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)
              })
              //swiftlint:disable:next line_length
              let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ : UIAlertAction!) -> Void in
              })

              alertController.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "tag_name"
              }
              alertController.addAction(goAction)
              alertController.addAction(cancelAction)
              self.present(alertController, animated: true, completion: nil)
              break
            case 1:
              // Tags recent
              let alertController = UIAlertController.init(title: "Tags recent", message: "", preferredStyle: .alert)

              let goAction = UIAlertAction.init(title: "Go", style: .default, handler: { _ -> Void in
                let tagNameTextField = alertController.textFields?[0]
                let maxTagIdTextField = alertController.textFields?[1]
                let minTagIdTextField = alertController.textFields?[2]
                let mediaCountTextField = alertController.textFields?[3]
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //swiftlint:disable:next force_cast line_length
                let controller = storyboard.instantiateViewController(withIdentifier: "TagRecentViewController") as!  TagRecentViewController
                //swiftlint:disable:next line_length
                controller.parameter = InstagramTagRouter.RecentMediaParameter(tagName: (tagNameTextField?.text)!, minId:  minTagIdTextField?.text, maxId: maxTagIdTextField?.text, count: Int((mediaCountTextField?.text)!))
                controller.title = self.rowsDataSource[indexPath.section][indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)
              })
              //swiftlint:disable:next line_length
              let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ : UIAlertAction!) -> Void in
              })

              alertController.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "tag_name"
              }
              alertController.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "max_tag_id"
              }
              alertController.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "min_tag_id"
              }
              alertController.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "count"
              }
              alertController.addAction(goAction)
              alertController.addAction(cancelAction)
              self.present(alertController, animated: true, completion: nil)
              break

            case 2:
              //Search
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              //swiftlint:disable:next force_cast line_length
              let controller = storyboard.instantiateViewController(withIdentifier: "UserSearchViewController") as! UserSearchViewController
              controller.title = rowsDataSource[indexPath.section][indexPath.row]
              self.navigationController?.pushViewController(controller, animated: true)

          default:
              break
          }
            break
        case 6:
            //Location
          switch indexPath.row {
          case 0:
              //Location id
              let alertController = UIAlertController.init(title: "TagName", message: "", preferredStyle: .alert)

              let goAction = UIAlertAction.init(title: "Go", style: .default, handler: { _ -> Void in
                let locationTextField = alertController.textFields?[0]
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //swiftlint:disable:next force_cast line_length
                let controller = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
                controller.locationId = locationTextField?.text
                self.navigationController?.pushViewController(controller, animated: true)
              })
              //swiftlint:disable:next line_length
              let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ : UIAlertAction!) -> Void in
              })

              alertController.addTextField { (textField: UITextField!) -> Void in
                  textField.placeholder = "location_id"
              }
              alertController.addAction(goAction)
              alertController.addAction(cancelAction)
              self.present(alertController, animated: true, completion: nil)
              break
          case 1:
              // Location recent
              let alertController = UIAlertController.init(title: "Tags recent", message: "", preferredStyle: .alert)

              let goAction = UIAlertAction.init(title: "Go", style: .default, handler: { _ -> Void in
                let locationIdTextField = alertController.textFields?[0]
                let minIdTextField = alertController.textFields?[1]
                let maxIdTextField = alertController.textFields?[2]
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //swiftlint:disable:next force_cast line_length
                let controller = storyboard.instantiateViewController(withIdentifier: "LocationRecentViewController") as!  LocationRecentViewController
                //swiftlint:disable:next line_length
                controller.locationParameter = InstagramLocationRouter.RecentMediaParameter(locationId: (locationIdTextField?.text)!, minId: minIdTextField?.text, maxId: maxIdTextField?.text)
                controller.title = self.rowsDataSource[indexPath.section][indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)
              })
              //swiftlint:disable:next line_length
              let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ : UIAlertAction!) -> Void in
              })

              alertController.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "location_id"
              }
              alertController.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "min_tag_id"
              }
              alertController.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "max_tag_id"
              }
              alertController.addAction(goAction)
              alertController.addAction(cancelAction)
              self.present(alertController, animated: true, completion: nil)
              break
          case 2:
              // Location search
              let alertController = UIAlertController.init(title: "Tags recent", message: "", preferredStyle: .alert)

              let goAction = UIAlertAction.init(title: "Go", style: .default, handler: { _ -> Void in
                let latitudeTextField = alertController.textFields?[0]
                let longitudeTextField = alertController.textFields?[1]
                let distanceTextField = alertController.textFields?[2]
                let facebookIdTextField = alertController.textFields?[3]
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //swiftlint:disable:next force_cast line_length
                let controller = storyboard.instantiateViewController(withIdentifier: "LocationSearchViewController") as!  LocationSearchViewController

                let latitude = NumberFormatter().number(from: (latitudeTextField?.text)!)?.doubleValue
                let longitude = NumberFormatter().number(from: (longitudeTextField?.text)!)?.doubleValue
                let distance = NumberFormatter().number(from: (distanceTextField?.text)!)?.doubleValue
                //swiftlint:disable:next line_length
                controller.locationSearchParameter = InstagramLocationRouter.SearchMediaParameter(longitude: longitude, latitude: latitude, distance: distance, facebookPlacesId: facebookIdTextField?.text)
                controller.title = self.rowsDataSource[indexPath.section][indexPath.row]
                self.navigationController?.pushViewController(controller, animated: true)
              })
              //swiftlint:disable:next line_length
              let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_ : UIAlertAction!) -> Void in
              })

              alertController.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "latitude"
              }
              alertController.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "longitude"
              }
              alertController.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "distance max = 750"
              }
              alertController.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "facebook_places_id"
              }
              alertController.addAction(goAction)
              alertController.addAction(cancelAction)
              self.present(alertController, animated: true, completion: nil)

            break
          default:
            break
          }
            break

        default:
            break

        }
    }
}
//swiftlint:disable:previous file_length
