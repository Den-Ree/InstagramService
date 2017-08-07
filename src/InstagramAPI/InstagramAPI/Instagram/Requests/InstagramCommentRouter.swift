//
//  CommentsEndpoint.swift
//  ConceptOffice
//
//  Created by Kirill Averyanov on 28/05/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

enum InstagramCommentRouter: AnyInstagramNetworkRouter {
  // MARK: - Requests
  case getComments(mediaId: String)
  case postComment(PostCommentParameter)
  case deleteComment(DeleteCommentParameter)
  // MARK: - Parameters
  struct DeleteCommentParameter {
    let mediaId: String
    let commentId: String
  }
  struct PostCommentParameter {
    let mediaId: String
    let text: String
    init(mediaId: String, text: String) {
      if !text.isGoodStringForComment() {
        assertionFailure("Text for comment isn't correct")
      }
      self.mediaId = mediaId
      self.text = text
    }
  }
}
