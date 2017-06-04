//
//  RelationshipViewController.swift
//  InstagramAPI
//
//  Created by Admin on 03.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class RelationshipViewController: UIViewController {

  var targetUserId : String?
  
  @IBOutlet weak var targetUserIDLabel: UILabel!
  @IBOutlet weak var avatarImageViev: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var fullNameLabel: UILabel!
  @IBOutlet weak var outgoingStatusLabel: UILabel!
  @IBOutlet weak var incomingStatusLabel: UILabel!
  @IBOutlet weak var follow: UIButton!
  @IBOutlet weak var ignore: UIButton!
  @IBOutlet weak var approve: UIButton!
  @IBOutlet weak var unfollow: UIButton!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      self.targetUserIDLabel.text = targetUserId
      self.setData()
      follow.addTarget(self, action: #selector(chooseButton(button:)), for: .touchUpInside)
      ignore.addTarget(self, action: #selector(chooseButton(button:)), for: .touchUpInside)
      approve.addTarget(self, action: #selector(chooseButton(button:)), for: .touchUpInside)
      unfollow.addTarget(self, action: #selector(chooseButton(button:)), for: .touchUpInside)
  }
  
  func chooseButton(button: UIButton){
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
  
  
  func setData(){
      let relationshipRequest = Instagram.RelationshipsEnpoint.Request.Get.relationship(userId: targetUserId!)
      InstagramManager.shared.networkClient.send(relationshipRequest, completion: {(relationship :  InstagramObjectResponse<Instagram.Relationship>?, error: Error?) in
        if error == nil{
            if let outgoingStatus = relationship?.data?.outgoingStatus{
              self.outgoingStatusLabel.text = outgoingStatus
            }
            if let incominStatus = relationship?.data?.incomingStatus{
              self.incomingStatusLabel.text = incominStatus
            }
      }
    })
    
      let userParams = Instagram.UsersEndpoint.Parameter.User.id(targetUserId!)
      let request = Instagram.UsersEndpoint.Get.user(userParams)
      self.targetUserIDLabel.text = targetUserId
      InstagramManager.shared.networkClient.send(request, completion: {(user : InstagramObjectResponse<Instagram.User>?, error : Error?) in
        if error == nil{
          if let profileImageURL = user?.data?.profilePictureURL{
            self.avatarImageViev.af_setImage(withURL: profileImageURL)
          }
          if let userName = user?.data?.username{
            self.userNameLabel.text = userName
          }
          if let fullName = user?.data?.fullName{
            self.fullNameLabel.text = fullName
          }
        }
      })
  }
  
  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func sendAction(_ sender: Any) {
    
      if follow.isSelected || unfollow.isSelected || approve.isSelected || ignore.isSelected{
      
        var action : Instagram.RelationshipsEnpoint.Parameter.Action? = nil
    
        if follow.isSelected{
          action = Instagram.RelationshipsEnpoint.Parameter.Action.follow
        }
        if unfollow.isSelected{
          action = Instagram.RelationshipsEnpoint.Parameter.Action.unfollow
        }
        if approve.isSelected{
          action = Instagram.RelationshipsEnpoint.Parameter.Action.approve
        }
        if ignore.isSelected{
          action = Instagram.RelationshipsEnpoint.Parameter.Action.ignore
        }
    
        let userParams = Instagram.RelationshipsEnpoint.Parameter.PostRelationshipParameter.init(userId: targetUserId!, action: action!)
        let request = Instagram.RelationshipsEnpoint.Request.Post.relationship(userParams)
        
        InstagramManager.shared.networkClient.send(request, completion: {
          (relationship : InstagramObjectResponse<Instagram.Relationship>?, error : Error?) in
            if error == nil{
            
              if relationship?.data == relationship?.data{
                
                if let outgoingStatus = relationship?.data?.outgoingStatus{
                  self.outgoingStatusLabel.text = outgoingStatus
            }
          }
        }
      })
        
    }
  }
}

