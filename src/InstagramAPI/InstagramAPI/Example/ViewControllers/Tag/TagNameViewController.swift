//
//  TagNameViewController.swift
//  InstagramAPI
//
//  Created by Admin on 05.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class TagNameViewController: UIViewController {
  
    var tagName : String?
    @IBOutlet fileprivate weak var mediaCountLabel: UILabel!
    @IBOutlet fileprivate weak var tagNameLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let router = InstagramTagRouter.getTag(name: tagName!)
        InstagramClient().send(router, completion: { (response: InstagramModelResponse<InstagramTag>?, error: Error?) in
          if error == nil{
              if let name = response?.data.name{
                  self.tagNameLabel.text?.append(" " + name)
              }
              if let mediaCount = response?.data.mediaCount{
                  self.mediaCountLabel.text?.append(" " + String(format: "%i", mediaCount))
              }
            }
        })
    }
}

