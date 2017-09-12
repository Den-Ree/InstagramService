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
      if (mediaIdTextField.text?.isEmpty)! {
          mediaIdTextField.text = "Please enter mediaId"
          return
      }
      if commentTextView.text.isEmpty {
          commentTextView.text = "Please enter your comment"
          return
      }
      //swiftlint:disable:next line_length
      let postCommentRouter = InstagramCommentRouter.postComment(.init(mediaId: mediaIdTextField.text!, text: commentTextView.text))

      InstagramClient().send(postCommentRouter, completion: { (response: InstagramMetaResponse?, error: Error?) in

        if response?.meta.code != 200 {
          print("Error: \(error!.localizedDescription):" + response!.meta.code.description)
        }
        self.commentTextView.text = error?.localizedDescription
      })
    }

  @IBAction func deleteComment(_ sender: Any) {
      if (commentIdLabel.text?.isEmpty)! {
        commentIdLabel.text = "Please write comment Id"
        return
      }
      if (mediaIdTextField.text?.isEmpty)! {
        mediaIdTextField.text = "Please enter mediaId"
        return
      }
      //swiftlint:disable:next line_length
      let deleteCommentRouter = InstagramCommentRouter.deleteComment(.init(mediaId: mediaIdTextField.text!, commentId: commentIdLabel.text!))

      InstagramClient().send(deleteCommentRouter, completion: { (response: InstagramMetaResponse?, error: Error?) in

        if response?.meta.code != 200 {
          print("Error: \(error!.localizedDescription):" + response!.meta.code.description)
        }
        self.commentTextView.text = error?.localizedDescription
      })
  }

}
