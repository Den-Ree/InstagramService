//
//  Comments.swift
//  ConceptOffice
//
//  Created by Denis on 21.02.17.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Foundation

extension Instagram {
  
  enum CommentsEndpoint {
    
    //MARK: - Requests
    
    enum Request {
      
      enum Get: InstagramRequestProtocol {
        case comment(mediaId: String)
      }
      
      enum Post: InstagramRequestProtocol {
        case comment(Parameter.PostCommentParameter)
      }
      
      enum Delete: InstagramRequestProtocol {
        case comment(Parameter.DeleteCommentParameter)
      }

    }
    
    
    //MARK: - Parameters
    
    enum Parameter {
    
      struct DeleteCommentParameter {
        let mediaId: String
        let commentId: String
      }
      
      struct PostCommentParameter {
        let mediaId: String
        let text: String
        //TODO: Need to create typealis and return error if string is not supports
        /**
         The total length of the comment cannot exceed 300 characters.
         The comment cannot contain more than 4 hashtags.
         The comment cannot contain more than 1 URL.
         The comment cannot consist of all capital letters.
         */
      }

    }
  }
}

//MARK: - InstagramRequestProtocol

extension Instagram.CommentsEndpoint.Request.Get {
  var path: String {
    switch self {
    case .comment(let mediaId):
      return "/media/\(mediaId)/comments"
    }
  }
  
  var parameters: InstagramRequestParameters {
    return [:]
  }
}

extension Instagram.CommentsEndpoint.Request.Post {
  var path: String {
    switch self {
    case .comment(let parameters):
      return "/media/\(parameters.mediaId)/comments"
    }
  }
  
  var parameters: InstagramRequestParameters {
    switch self {
    case .comment(let parameters):
      return [
        Instagram.Keys.Comment.text : parameters.text as AnyObject
      ]
    }
  }
  
  var method: HTTPMethod {
    return Instagram.Keys.HTTPMethod.post
  }
}

extension Instagram.CommentsEndpoint.Request.Delete {
  var path: String {
    switch self {
    case .comment(let parameter):
      return "/media/\(parameter.mediaId)/comments/\(parameter.commentId)"
    }
  }
  
  var parameters: InstagramRequestParameters {
    //TODO Need to fill
    return [:]
  }


  var method: HTTPMethod {
    return Instagram.Keys.HTTPMethod.delete
  }
}
