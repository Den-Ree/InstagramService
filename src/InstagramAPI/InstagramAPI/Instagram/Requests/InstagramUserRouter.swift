//
//  UserEndpoint.swift
//  ConceptOffice
//
//  Created by Kirill Averyanov on 27/05/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

enum InstagramUserRouter: AnyInstagramNetworkRouter {
  // MARK: - Requests
  case getUser(UserParameter)
  case getRecentMedia(RecentMediaParameter)
  case getLikedMedia(LikedMediaParameter)
  case getSearch(SearchUserParameter)
  // MARK: - Parameters
  struct SearchUserParameter {
    let query: String
    var count: Int?
    // MARK: - Init
    init(query: String, count: Int) {
      self.query = query
      self.count = count
    }
  }
  struct LikedMediaParameter {
    let user: UserParameter
    var count: Int?
    var maxLikeId: String?
    // MARK: - Init
    init(user: UserParameter, count: Int, maxLikeId: String) {
      self.user = user
      self.count = count
      self.maxLikeId = maxLikeId
    }
  }
  struct RecentMediaParameter {
    let user: UserParameter
    let count: Int?
    let minId: String?
    let maxId: String?
    // MARK: - Init
    init(user: UserParameter, count: Int, minId: String, maxId: String) {
      self.user = user
      self.count = count
      self.minId = minId
      self.maxId = maxId
    }
  }
  enum UserParameter {
    case id(String)
    case owner
    // MARK: - Init
    init(_ userId: String? = nil) {
      if let userId = userId {
        self = .id(userId)
      } else {
        self = .owner
      }
    }
  }
}
