//
//  MediaViewController.swift
//  InstagramAPI
//
//  Created by Admin on 03.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController {

  var mediaParameter: InstagramMediaRouter.MediaParameter = .id(String.emptyString)

  @IBOutlet fileprivate weak var mediaView: UIImageView!
  @IBOutlet fileprivate weak var userLabel: UILabel!
  @IBOutlet fileprivate weak var userHasLikedLabel: UILabel!
  @IBOutlet fileprivate weak var createdDateLabel: UILabel!
  @IBOutlet fileprivate weak var linkLabel: UILabel!
  @IBOutlet fileprivate weak var captionLabel: UILabel!
  @IBOutlet fileprivate weak var tagsCountLabel: UILabel!
  @IBOutlet fileprivate weak var likesCountLabel: UILabel!
  @IBOutlet fileprivate weak var commentCountLabel: UILabel!
  @IBOutlet fileprivate weak var locationLabel: UILabel!
  @IBOutlet fileprivate weak var typeLabel: UILabel!
  @IBOutlet fileprivate weak var tagsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let mediaRouter = InstagramMediaRouter.getMedia(mediaParameter)
        //swiftlint:disable:next line_length
        InstagramClient().send(mediaRouter, completion: { (media: InstagramModelResponse<InstagramMedia>?, error: Error?) in
          if error == nil {

              if let data = media?.data {

                self.userLabel.text?.append(data.user.username)
                self.userHasLikedLabel.text?.append(data.userHasLiked.description)
                self.createdDateLabel.text?.append(data.createdDate.description)
                self.linkLabel.text?.append(data.link)
                self.captionLabel.text = data.caption.text
                self.tagsCountLabel.text?.append(String(data.tagsCount))
                self.commentCountLabel.text?.append(String(data.commentsCount))
                self.likesCountLabel.text?.append(String(data.likesCount))
                //swiftlint:disable:next line_length
                self.locationLabel.text?.append( String(describing: data.location.latitude) + " " + String(describing: data.location.longitude))
                if data.type == .image {
                    self.mediaView.af_setImage(withURL: (data.image.lowResolution.url)!)
                    self.typeLabel.text?.append("image")
                } else {
                    self.typeLabel.text?.append("video")
                }
                for i in 0...data.tags.count-1 {
                    self.tagsLabel.text?.append(String.hashtagString+data.tags[i])
                }
              }
            }
        })
    }
}
