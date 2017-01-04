//
//  UserViewController.swift
//  InstagramAPI
//
//  Created by Yakovlev, Alexander on 1/4/17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class UserViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InstagramManager.shared.userService.fetchUser(userId: nil) { (user, error) in
            if error == nil {
                if user == user {
                    if let url = user?.profilePictureURL?.absoluteString {
                        Alamofire.request(url).responseImage { response in
                            print(response.request)
                            print(response.response)
                            debugPrint(response.result)
                            if let image = response.result.value {
                                self.avatarImageView.image = image
                            }
                        }
                    }
                    
                    if let fullName = user?.fullName {
                        self.title = fullName
                    }
                    if let nickname = user?.username {
                        self.nicknameLabel.text = nickname
                    }
                    if let posts = user?.counts?.media {
                        self.postsLabel.text = "\(posts) posts"
                    }
                    if let followers = user?.counts?.followedBy {
                        self.followersLabel.text = "\(followers) followers"
                    }
                    if let following = user?.counts?.follows {
                        self.followingLabel.text = "\(following) following"
                    }
                    if let bio = user?.bio {
                        self.bioLabel.text = bio
                    }
                    if let website = user?.website?.absoluteString {
                        self.websiteLabel.text = website
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
