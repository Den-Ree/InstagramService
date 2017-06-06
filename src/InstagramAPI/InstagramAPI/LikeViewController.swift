//
//  LikeViewController.swift
//  InstagramAPI
//
//  Created by Admin on 05.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class LikeViewController: UIViewController {

  var mediaId : String?
  @IBOutlet fileprivate weak var userListLabel: UILabel!
  @IBOutlet fileprivate weak var mediaIdLabel: UILabel!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mediaIdLabel.text?.append(" "+mediaId!)
        let request = Instagram.LikesEndpoint.Request.Get.likes(mediaId: mediaId!)
        InstagramManager.shared.networkClient.send(request, completion: {
          (likes: InstagramArrayResponse<Instagram.Like>? , error : Error?) in
            if error == nil{
              if let data = likes?.data{
                if data.count > 0{
                   for  i in 0...data.count - 1{
                    self.userListLabel.text?.append(data[i].username!+", ")
                  }
                } else{
                  self.userListLabel.text = "Nobody has liked this media"
                }
              }
            }
        })
    }

  @IBAction func post(_ sender: Any) {
        let request = Instagram.LikesEndpoint.Request.Post.likes(mediaId: mediaId!)
        InstagramManager.shared.networkClient.send(request, completion: {
          (responce: InstagramObjectResponse<Instagram.Like>?, error: Error?) in
            self.userListLabel.text = error?.localizedDescription
        })
  }
  
  @IBAction func deleteLike(_ sender: Any) {
        let request = Instagram.LikesEndpoint.Request.Delete.likes(mediaId: mediaId!)
        InstagramManager.shared.networkClient.send(request, completion: {
          (responce: InstagramObjectResponse<Instagram.Like>?, error: Error?) in
            self.userListLabel.text = error?.localizedDescription
        })
  }
}
