//
//  CommentsEndpoint.swift
//  ConceptOffice
//
//  Created by Kirill Averyanov on 28/05/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

public extension String {
  public func isGoodStringForComment() -> Bool {
    if self.characters.count >= 300
      || self.components(separatedBy: "#").count > 3
      || self.components(separatedBy: "http").count > 1 {
      return false
    }
    return true
  }
}

public enum InstagramCommentRouter: AnyInstagramNetworkRouter {
  // MARK: - Requests
  case getComments(mediaId: String)
  case postComment(PostCommentParameter)
  case deleteComment(DeleteCommentParameter)
  // MARK: - Parameters
  public struct DeleteCommentParameter {
    public let mediaId: String
    public let commentId: String
  }
  public struct PostCommentParameter {
    public let mediaId: String
    public let text: String
    public init(mediaId: String, text: String) {
      if !text.isGoodStringForComment() {
        assertionFailure("Text for comment isn't correct")
      }
      self.mediaId = mediaId
      self.text = text
    }
  }
}
