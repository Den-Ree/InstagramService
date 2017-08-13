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
        let router = InstagramLikeRouter.getLikes(mediaId: mediaId!)
        InstagramClient().send(router, completion: { (likes: InstagramArrayResponse<InstagramLike>?, error: Error?) in
          if error == nil{
                if let data = likes?.data{
                  if data.count > 0{
                    for  i in 0...data.count - 1{
                      self.userListLabel.text?.append(data[i].username+", ")
                    }
                  } else{
                    self.userListLabel.text = "Nobody has liked this media"
                  }
                }
              }
        })
    }

  @IBAction func post(_ sender: Any) {
        let router = InstagramLikeRouter.postLike(mediaId: mediaId!)
        InstagramClient().send(router, completion: { (response: InstagramModelResponse<InstagramLike>?, error: Error?) in
          self.userListLabel.text = error?.localizedDescription
        })
  }
  
  @IBAction func deleteLike(_ sender: Any) {
        let router = InstagramLikeRouter.deleteLike(mediaId: mediaId!)
        InstagramClient().send(router, completion: { (response: InstagramModelResponse<InstagramLike>?, error: Error?) in
          self.userListLabel.text = error?.localizedDescription
        })
    }
}
