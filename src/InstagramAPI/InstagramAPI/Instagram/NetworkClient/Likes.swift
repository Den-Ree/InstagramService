//
//  Likes.swift
//  ConceptOffice
//
//  Created by Denis on 21.02.17.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

extension Instagram {
  
  enum LikesEndpoint {
    
    //Requests
    enum Get: InstagramRequestProtocol {
      case likes(mediaId: InstagramObjectId)
    }
    
    enum Post: InstagramRequestProtocol {
      case likes(mediaId: InstagramObjectId)
    }
    
    enum Delete: InstagramRequestProtocol {
      case likes(DeleteLikeParameter)
    }
    
    //Parameters
    struct DeleteLikeParameter {
      let mediaId: InstagramObjectId
      let commentId: InstagramObjectId
    }
  }
}

extension Instagram.LikesEndpoint.Get {
  var path: String {
    switch self {
    case .likes(let mediaId):
      return "/media/\(mediaId)/likes"
    }
  }
  
  var parameters : [String : Any]{
    // TODO Need to fill
    return [:]
  }

}

extension Instagram.LikesEndpoint.Post {
  var path: String {
    switch self {
    case .likes(let mediaId):
      return "/media/\(mediaId)/likes"
    }
  }
  
  var parameters : [String : Any]{
    // TODO Need to fill
    return [:]
  }

  
  var method: HTTPMethod {
    return .post
  }
}

extension Instagram.LikesEndpoint.Delete {
  var path: String {
    switch self {
    case .likes(let mediaId):
      return "/media/\(mediaId)/likes"
    }
  }
  
  var parameters : [String : Any]{
    // TODO Need to fill
    return [:]
  }


  var method: HTTPMethod {
    return .delete
  }
}
