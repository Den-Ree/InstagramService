//
//  InstargamCommentRequest+NetworkRoutable.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

extension InstagramCommentRouter: AnyNetworkRoutable {
  // MARK: - Private
  public var method: HTTPMethod {
    switch self {
    case .getComments:
      return .get
    case .postComment:
      return .post
    case .deleteComment:
      return .delete
    }
  }
  public var path: String {
    switch self {
    case let .getComments(mediaId):
      return "/media/\(mediaId)/comments"
    case let .postComment(parameters):
      return "/media/\(parameters.mediaId)/comments"
    case let .deleteComment(parameter):
      return "/media/\(parameter.mediaId)/comments/\(parameter.commentId)"
    }
  }
  public var parameters: InstagramRequestParameters {
    switch self {
    case let .postComment(parameters):
      return [
        Instagram.Keys.Comment.text: parameters.text
      ]
    case .deleteComment, .getComments: return [:]
    }
  }
}
