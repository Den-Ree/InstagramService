//
//  RelationshipsEndpoint.swift
//  ConceptOffice
//
//  Created by Kirill Averyanov on 28/05/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

public enum InstagramRelationshipRouter: AnyInstagramNetworkRouter {
  // MARK: - Requests
  case getFollows
  case getFollowedBy
  case getRequestedBy
  case getRelationship(userId: String)
  case postRelationship(PostRelationshipParameter)
  // MARK: - Parameters
  public struct PostRelationshipParameter {
    public let userId: String
    public let action: Action
    // MARK: Nested
    //swiftlint:disable:next nesting
    public enum Action: String {
      case follow
      case unfollow
      case approve
      case ignore
    }
  }
}
