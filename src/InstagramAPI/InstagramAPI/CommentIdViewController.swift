//
//  CommentIdViewController.swift
//  InstagramAPI
//
//  Created by Admin on 04.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class CommentIdViewController: UIViewController {
  
  @IBOutlet fileprivate weak var commentIdLabel: UITextField!
  @IBOutlet fileprivate weak var commentTextView: UITextView!
  @IBOutlet fileprivate weak var mediaIdTextField: UITextField!
  
  @IBAction func post(_ sender: Any) {
      if (mediaIdTextField.text?.isEmpty)!{
          mediaIdTextField.text = "Please enter mediaId"
          return
      }
      if commentTextView.text.isEmpty{
          commentTextView.text = "Please enter your comment"
          return
      }
    
      let params = Instagram.CommentsEndpoint.Parameter.PostCommentParameter.init(mediaId: mediaIdTextField.text!, text: commentTextView.text)
      let request = Instagram.CommentsEndpoint.Request.Post.comment(params)
    
      InstagramManager.shared.networkClient.send(request, completion: {(responce: InstagramObjectResponse<Instagram.Comment>?, error: Error?) in
          self.commentTextView.text = error?.localizedDescription
      })
  }
  
  @IBAction func deleteComment(_ sender: Any) {
      if (commentIdLabel.text?.isEmpty)!{
        commentIdLabel.text = "Please write comment Id"
        return
      }
      if (mediaIdTextField.text?.isEmpty)!{
        mediaIdTextField.text = "Please enter mediaId"
        return
      }
      let params = Instagram.CommentsEndpoint.Parameter.DeleteCommentParameter.init(mediaId: mediaIdTextField.text!, commentId: commentIdLabel.text!)
      let request = Instagram.CommentsEndpoint.Request.Delete.comment(params)
    
      InstagramManager.shared.networkClient.send(request, completion: {
        (responce: InstagramObjectResponse<Instagram.Comment>?, error: Error?) in
          self.commentIdLabel.text = error?.localizedDescription
      })
  }
 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
}
