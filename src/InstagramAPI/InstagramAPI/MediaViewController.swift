//
//  MediaViewController.swift
//  InstagramAPI
//
//  Created by Admin on 03.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController {

  var mediaParameter : Instagram.MediaEndpoint.Parameter.Media = .id("")
  
  @IBOutlet weak var mediaView: UIImageView!
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var userHasLikedLabel: UILabel!
  @IBOutlet weak var createdDateLabel: UILabel!
  @IBOutlet weak var linkLabel: UILabel!
  @IBOutlet weak var captionLabel: UILabel!
  @IBOutlet weak var tagsCountLabel: UILabel!
  @IBOutlet weak var likesCountLabel: UILabel!
  @IBOutlet weak var commentCountLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var tagsLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let request = Instagram.MediaEndpoint.Get.media(mediaParameter)
          InstagramManager.shared.networkClient.send(request, completion: {
            (media : InstagramObjectResponse<Instagram.Media>?, error: Error?) in
          
            if error == nil{
              
              if let data = media?.data{
                if let user = data.user{
                  if let userName = user.username{
                    self.userLabel.text?.append(userName)
                  }
                }
                if let hasLiked = data.userHasLiked{
                  self.userHasLikedLabel.text?.append(hasLiked.description)
                }
                if let date = data.createdDate{
                  self.createdDateLabel.text?.append(date.defaultString)
                }
                if let link = data.link{
                  self.linkLabel.text?.append(link.absoluteString)
                }
                if let caption = data.caption{
                  if let text = caption.text{
                    self.captionLabel.text = text
                  }
                }
              
                self.tagsCountLabel.text?.append(String(data.tagsCount))
                self.commentCountLabel.text?.append(String(data.commentsCount))
                self.likesCountLabel.text?.append(String(data.likesCount))
              
                if let location = data.location{
                  self.locationLabel.text?.append( String(describing: location.latitude) + " " + String(describing: location.longitude))
                }
                if let type = data.type{
                  self.typeLabel.text?.append(type)
                }
                if let tags = data.tags{
                  for i in 0...tags.count-1{
                    self.tagsLabel.text?.append(String.hashtagString+tags[i])
                  }
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
