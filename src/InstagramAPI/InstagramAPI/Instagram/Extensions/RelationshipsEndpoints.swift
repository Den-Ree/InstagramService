//
//  RelationshipsEndpoints.swift
//  InstagramAPI
//
//  Created by Admin on 03.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation

extension InstagramEndpoints{
  
  enum RelationshipsEnpoint {
    
    //MARK: - Requests
    
    enum Request {
      
      enum Get{
        case follows
        case followedBy
        case requestedBy
        case relationship(userId: String)
      }
      
      enum Post{
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
