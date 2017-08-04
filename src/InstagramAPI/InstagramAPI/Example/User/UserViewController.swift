//
//  UserViewController.swift
//  InstagramAPI
//
//  Created by Yakovlev, Alexander on 1/4/17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//
/*
import UIKit
import AlamofireImage
import Alamofire

class UserViewController: UIViewController {
    
    var userID: String?
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nicknameLabel: UILabel!
    @IBOutlet private weak var postsLabel: UILabel!
    @IBOutlet private weak var followersLabel: UILabel!
    @IBOutlet private weak var followingLabel: UILabel!
    @IBOutlet private weak var bioLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userParams = Instagram.UsersEndpoint.Parameter.User(userID)
        let request = Instagram.UsersEndpoint.Get.user(userParams)
        
        InstagramManager.shared.networkClient.send(request, completion: { (user: InstagramObjectResponse<Instagram.User>?, error: Error?) in
            if error == nil {
                if user?.data == user?.data {
                    if let url = user?.data?.profilePictureURL?.absoluteString {
                        Alamofire.request(url).responseImage { response in
                            //debugPrint(response.result)
                            if let image = response.result.value {
                                self.avatarImageView.image = image
                            }
                        }
                    }
                    
                    if let fullName = user?.data?.fullName {
                        self.title = fullName
                    }
                    if let nickname = user?.data?.username {
                        self.nicknameLabel.text = nickname
                    }
                    if let posts = user?.data?.counts?.media {
                        self.postsLabel.text = "\(posts) posts"
                    }
                    if let followers = user?.data?.counts?.followedBy {
                        self.followersLabel.text = "\(followers) followers"
                    }
                    if let following = user?.data?.counts?.follows {
                        self.followingLabel.text = "\(following) following"
                    }
                    if let bio = user?.data?.bio {
                        self.bioLabel.text = bio
                    }
                    if let website = user?.data?.website?.absoluteString {
                        self.websiteLabel.text = website
                    }
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  
      
      
      
      // Dispose of any resources that can be recreated.
    }
}
*/
