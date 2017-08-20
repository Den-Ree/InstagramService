//
//  InstagramUserRequest+Routable.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

extension InstagramUserRouter: AnyNetworkRoutable {
  // MARK: - AnyNetworkRoutable
  public var method: HTTPMethod {
    return .get
  }
  public var path: String {
    switch self {
    case let .getUser(user):
      return "/users/\(user.pathComponent)/"
    case .getLikedMedia:
      // Liked media only from self
      return "/users/self/media/liked"
    case let .getRecentMedia(parameters):
      return "/users/\(parameters.user.pathComponent)/media/recent/"
    case .getSearch:
      return "/users/search"
    }
  }
  public var parameters: InstagramRequestParameters {
    var result: InstagramRequestParameters = InstagramRequestParameters()
    switch self {
    case .getUser:
      result = [:]
    case let .getLikedMedia(parameters):
      if let count = parameters.count {
        result[Instagram.Keys.Media.count] = count
      }
      if let maxLikedId = parameters.maxLikeId {
        result[Instagram.Keys.Pagination.maxLikeId] = maxLikedId
      }
    case let .getRecentMedia(parameters):
      if let count = parameters.count {
        result[Instagram.Keys.Media.count] = count
      }
      if let maxId = parameters.maxId {
        result[Instagram.Keys.Pagination.maxId] = maxId
      }
      if let minId = parameters.minId {
        result[Instagram.Keys.Pagination.minId] = minId
      }
    case let .getSearch(parameters):
      result[Instagram.Keys.Data.query] = parameters.query
      if let count = parameters.count {
        result[Instagram.Keys.Media.count] = count
      }
    }
    return result
  }
}

// MARK: - Helpers

public extension InstagramUserRouter.UserParameter {
  public var pathComponent: String {
    switch self {
    case .id(let userId):
      return "\(userId)"
    case .owner:
      return "self"
    }
  }
}
