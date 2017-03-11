//
//  Relationships.swift
//  ConceptOffice
//
//  Created by Denis on 21.02.17.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

extension Instagram {
  
  enum RelationshipsEnpoint {
    
    //Requests
    enum Get: InstagramRequestProtocol {
      case follows
      case followedBy
      case requestedBy
      case relationship(userId: InstagramObjectId)
    }
    
    enum Post: InstagramRequestProtocol {
      case relationship(PostRelationshipParameter)
    }
    
    //Parameters
    struct PostRelationshipParameter {
      let userId: InstagramObjectId
      let action: Action
    }
    
    enum Action: String {
      case follow =	"follow"
      case unfollow = "unfollow"
      case approve = "approve"
      case ignore = "ignore"
    }
  }
}

extension Instagram.RelationshipsEnpoint.Get {
  var path: String {
    switch self {
    case .follows:
      return "/users/self/follows"
    case .followedBy:
      return "/users/self/followed-by"
    case .requestedBy:
      return "/users/self/requested-by"
    case .relationship(let userId):
      return "/users/\(userId)/relationship"
    }
  }
  
  var parameters : InstagramRequestParameters{
    return [:]
  }
}

extension Instagram.RelationshipsEnpoint.Post {
  var path: String {
    switch self {
    case .relationship(let parameters):
      return "/users/\(parameters.userId)/relationship"
    }
  }
  
  var parameters: InstagramRequestParameters {
    switch self {
    case .relationship(let parameter):
      return [
        "action": parameter.action.rawValue as AnyObject
      ]
    }
  }
  
  var method: HTTPMethod {
    return .post
  }
}
