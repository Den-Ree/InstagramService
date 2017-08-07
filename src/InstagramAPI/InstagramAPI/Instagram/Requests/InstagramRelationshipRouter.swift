//
//  RelationshipsEndpoint.swift
//  ConceptOffice
//
//  Created by Kirill Averyanov on 28/05/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

enum InstagramRelationshipRouter: AnyInstagramNetworkRouter {
  // MARK: - Requests
  case getFollows
  case getFollowedBy
  case getRequestedBy
  case getRelationship(userId: String)
  case postRelationship(PostRelationshipParameter)
  // MARK: - Parameters
  struct PostRelationshipParameter {
    let userId: String
    let action: Action
    // MARK: Nested
    enum Action: String {
      case follow
      case unfollow
      case approve
      case ignore
    }
  }
}
