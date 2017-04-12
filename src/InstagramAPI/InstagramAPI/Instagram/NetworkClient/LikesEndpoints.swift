//
//  Likes.swift
//  ConceptOffice
//
//  Created by Denis on 21.02.17.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Foundation

extension Instagram {
  
  enum LikesEndpoint {
    
    //MARK: - Requests
    
    enum Request {
    
      enum Get: InstagramRequestProtocol {
        case likes(mediaId: String)
      }
    
      enum Post: InstagramRequestProtocol {
        case likes(mediaId: String)
      }
    
      enum Delete: InstagramRequestProtocol {
        case likes(Parameter.DeleteLikeParameter)
      }
    }
        
    //MARK: - Parameters
    
    enum Parameter {
      struct DeleteLikeParameter {
      let mediaId: String
      let commentId: String
      }
    }
  }
}

//MARK: - InstagramRequestProtocol

extension Instagram.LikesEndpoint.Request.Get {
  var path: String {
    switch self {
    case .likes(let mediaId):
      return "/media/\(mediaId)/likes"
    }
  }
  
  var parameters : InstagramRequestParameters{
    // TODO Need to fill
    return [:]
  }

}

extension Instagram.LikesEndpoint.Request.Post {
  var path: String {
    switch self {
    case .likes(let mediaId):
      return "/media/\(mediaId)/likes"
    }
  }
  
  var parameters : InstagramRequestParameters{
    return [:]
  }

  
  var method: HTTPMethod {
    return Instagram.Keys.HTTPMethod.post
  }
}

extension Instagram.LikesEndpoint.Request.Delete {
  var path: String {
    switch self {
    case .likes(let mediaId):
      return "/media/\(mediaId)/likes"
    }
  }
  
  var parameters : InstagramRequestParameters{
    return [:]
  }


  var method: HTTPMethod {
    return Instagram.Keys.HTTPMethod.delete
  }
}
