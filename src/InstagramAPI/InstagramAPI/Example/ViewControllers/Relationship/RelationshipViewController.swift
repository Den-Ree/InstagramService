//
//  RelationshipViewController.swift
//  InstagramAPI
//
//  Created by Admin on 03.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class RelationshipViewController: UIViewController {

  var targetUserId: String?

  @IBOutlet fileprivate weak var targetUserIDLabel: UILabel!
  @IBOutlet fileprivate weak var avatarImageViev: UIImageView!
  @IBOutlet fileprivate weak var userNameLabel: UILabel!
  @IBOutlet fileprivate weak var fullNameLabel: UILabel!
  @IBOutlet fileprivate weak var outgoingStatusLabel: UILabel!
  @IBOutlet fileprivate weak var incomingStatusLabel: UILabel!
  @IBOutlet fileprivate weak var follow: UIButton!
  @IBOutlet fileprivate weak var ignore: UIButton!
  @IBOutlet fileprivate weak var approve: UIButton!
  @IBOutlet fileprivate weak var unfollow: UIButton!

  override func viewDidLoad() {
      super.viewDidLoad()
      self.targetUserIDLabel.text = targetUserId
      self.setData()
      follow.addTarget(self, action: #selector(chooseButton(button:)), for: .touchUpInside)
      ignore.addTarget(self, action: #selector(chooseButton(button:)), for: .touchUpInside)
      approve.addTarget(self, action: #selector(chooseButton(button:)), for: .touchUpInside)
      unfollow.addTarget(self, action: #selector(chooseButton(button:)), for: .touchUpInside)
  }

  @objc func chooseButton(button: UIButton) {
      follow.titleLabel?.textColor = UIColor.blue
      follow.isSelected = false

      ignore.titleLabel?.textColor = UIColor.blue
      ignore.isSelected = false

      approve.titleLabel?.textColor = UIColor.blue
      approve.isSelected = false

      unfollow.titleLabel?.textColor = UIColor.blue
      unfollow.isSelected = false

      button.isSelected = true
      button.titleLabel?.textColor = UIColor.black
  }

  func setData() {
      let relationshipRouter = InstagramRelationshipRouter.getRelationship(userId: targetUserId!)
      //swiftlint:disable:next line_length
      InstagramClient().send(relationshipRouter, completion: { (relationship: InstagramModelResponse<InstagramRelationship>?, error: Error?) in

        if error == nil {
              if let outgoingStatus = relationship?.data.outgoingStatus {
                self.outgoingStatusLabel.text = outgoingStatus
              }
              if let incominStatus = relationship?.data.incomingStatus {
                self.incomingStatusLabel.text = incominStatus
              }
        }
      })

      let targetUserRouter = InstagramUserRouter.getUser(.id(targetUserId!))
      self.targetUserIDLabel.text = self.targetUserId
      //swiftlint:disable:next line_length
      InstagramClient().send(targetUserRouter, completion: { (user: InstagramModelResponse<InstagramUser>?, error: Error?) in
        if error == nil {
          if let profileImageURL = user?.data.profilePictureUrl {
            self.avatarImageViev.af_setImage(withURL: profileImageURL)
          }
          if let userName = user?.data.username {
            self.userNameLabel.text = userName
          }
          if let fullName = user?.data.fullName {
            self.fullNameLabel.text = fullName
          }
        }
      })
    }

  @IBAction func sendAction(_ sender: Any) {

      if follow.isSelected || unfollow.isSelected || approve.isSelected || ignore.isSelected {

        var action: InstagramRelationshipRouter.PostRelationshipParameter.Action? = nil

        if follow.isSelected {
          action = InstagramRelationshipRouter.PostRelationshipParameter.Action.follow
        }
        if unfollow.isSelected {
          action = InstagramRelationshipRouter.PostRelationshipParameter.Action.unfollow
        }
        if approve.isSelected {
          action = InstagramRelationshipRouter.PostRelationshipParameter.Action.approve
        }
        if ignore.isSelected {
          action = InstagramRelationshipRouter.PostRelationshipParameter.Action.ignore
        }
        //swiftlint:disable:next line_length
        let postRelationshipRouter = InstagramRelationshipRouter.postRelationship(.init(userId: targetUserId!, action: action!))
        //swiftlint:disable:next line_length
        InstagramClient().send(postRelationshipRouter, completion: { (relationship: InstagramModelResponse<InstagramRelationship>?, error: Error?) in
          if error == nil {

              if relationship?.data == relationship?.data {

                if let outgoingStatus = relationship?.data.outgoingStatus {
                  self.outgoingStatusLabel.text = outgoingStatus
                }
            }
          }
        })
    }
  }
}
