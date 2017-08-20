//
//  InstagramRelationshipRequest+Routable.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

// MARK: - Get

extension InstagramRelationshipRouter: AnyNetworkRoutable {
  // MARK: - AnyNetworkRoutable
  public var method: HTTPMethod {
    switch self {
    case .getFollowedBy,
         .getFollows,
         .getRelationship,
         .getRequestedBy:
      return .get
    case let .postRelationship(parameter):
      return .post
    }
  }
  public var path: String {
    switch self {
    case .getFollows:
      return "/users/self/follows"
    case .getFollowedBy:
      return "/users/self/followed-by"
    case .getRequestedBy:
      return "/users/self/requested-by"
    case let .getRelationship(userId):
      return "/users/\(userId)/relationship"
    case let .postRelationship(parameters):
      return "/users/\(parameters.userId)/relationship"
    }
  }
  public var parameters: InstagramRequestParameters {
    switch self {
    case .getFollowedBy,
         .getFollows,
         .getRelationship,
         .getRequestedBy:
      return [:]
    case let .postRelationship(parameter):
      return [
        Instagram.Keys.User.Counts.action: parameter.action.rawValue
      ]
    }
  }
}
