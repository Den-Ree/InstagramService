//
//  Relationships.swift
//  ConceptOffice
//
//  Created by Denis on 21.02.17.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Foundation

extension Instagram {
  
  enum RelationshipsEnpoint {
    
    //MARK: - Requests
    
    enum Request {
      
      enum Get: InstagramRequestProtocol {
        case follows
        case followedBy
        case requestedBy
        case relationship(userId: String)
      }
      
      enum Post: InstagramRequestProtocol {
        case relationship(Parameter.PostRelationshipParameter)
      }
    }
    
    //MARK: - Parameters
    
    enum Parameter {
      struct PostRelationshipParameter {
        let userId: String
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
}

//MARK: - InstagramRequestProtocol

extension Instagram.RelationshipsEnpoint.Request.Get {
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

extension Instagram.RelationshipsEnpoint.Request.Post {
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
        Instagram.Keys.User.Counts.action: parameter.action.rawValue as AnyObject
      ]
    }
  }
  
  var method: HTTPMethod {
    return Instagram.Keys.HTTPMethod.post
  }
}
