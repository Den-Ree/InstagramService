//
//  UserEndpoint.swift
//  ConceptOffice
//
//  Created by Kirill Averyanov on 27/05/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

public enum InstagramUserRouter: AnyInstagramNetworkRouter {
  // MARK: - Requests
  case getUser(UserParameter)
  case getRecentMedia(RecentMediaParameter)
  case getLikedMedia(LikedMediaParameter)
  case getSearch(SearchUserParameter)
  // MARK: - Parameters
  public struct SearchUserParameter {
    public let query: String
    public var count: Int?
    // MARK: - Init
    public init(query: String, count: Int) {
      self.query = query
      self.count = count
    }
  }
  public struct LikedMediaParameter {
    public let user: UserParameter
    public var count: Int?
    public var maxLikeId: String?
    // MARK: - Init
    public init(user: UserParameter, count: Int, maxLikeId: String) {
      self.user = user
      self.count = count
      self.maxLikeId = maxLikeId
    }
  }
  public struct RecentMediaParameter {
    public let user: UserParameter
    public let count: Int?
    public let minId: String?
    public let maxId: String?
    // MARK: - Init
    public init(user: UserParameter, count: Int, minId: String, maxId: String) {
      self.user = user
      self.count = count
      self.minId = minId
      self.maxId = maxId
    }
  }
  public enum UserParameter {
    //swiftlint:disable:next identifier_name
    case id(String)
     case owner
    // MARK: - Init
    public init(_ userId: String? = nil) {
      if let userId = userId {
        self = .id(userId)
      } else {
        self = .owner
      }
    }
  }
}
