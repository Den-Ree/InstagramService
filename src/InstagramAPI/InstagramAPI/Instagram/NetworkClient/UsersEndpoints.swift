//
//  Users.swift
//  ConceptOffice
//
//  Created by Denis on 21.02.17.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Foundation

extension Instagram {
  
  public enum UsersEndpoint {
    
    //MARK: - Requests

    enum Get: InstagramRequestProtocol {
      case user(Parameter.User)
      case recentMedia(Parameter.RecentMedia)
      case likedMedia(Parameter.LikedMedia)
      case search(Parameter.SearchUser)
    }

    //MARK: - Parameters

    enum Parameter {
      
      struct SearchUser {
        let query: String
        var count: Int? = nil

        init(query: String, count: Int) {
          self.query = query
          self.count = count
        }
      }

      struct LikedMedia {
        let user: User
        var count: Int?
        var maxLikeId: String?

        init(user: User, count: Int, maxLikeId: String) {
          self.user = user
          self.count = count
          self.maxLikeId = maxLikeId
        }
      }

      struct RecentMedia {
        let user: User
        let count: Int?
        let minId: String?
        let maxId: String?

        init(user: User, count: Int, minId: String, maxId: String) {
          self.user = user
          self.count = count
          self.minId = minId
          self.maxId = maxId
        }
      }

      enum User {
        case id(String)
        case owner

        init(_ userId: String? = nil) {
          if let userId = userId {
            self = .id(userId)
          }
          else {
            self = .owner
          }
        }
      }
    }
  }
}

//MARK: - InstagramRequestProtocol

extension Instagram.UsersEndpoint.Parameter.User {
  var pathComponent: String {
    var result = String()
    
    switch self {
    case .id(let userId):
      result = "\(userId)"
    case .owner:
      result = "self"
    }
    
    return result
  }
}

extension Instagram.UsersEndpoint.Get {
  
  var path: String {
    switch self {
    case .user(let user):
      return "/users/\(user.pathComponent)"
    case .likedMedia(_):
      return "/users/self/media/liked"
    case .recentMedia(let parameters):
      return "/users/\(parameters.user.pathComponent)/media/recent"
    case .search(_):
      return "/users/search"
    }
  }
  
  var parameters: InstagramRequestParameters {
    
    switch self {
    case .user( _):
      return [:]

    case .likedMedia(let parameters):
      var result = InstagramRequestParameters()
      if let count = parameters.count {
        result[Instagram.Keys.Media.count] = count
      }
      if let maxLikedId = parameters.maxLikeId {
        result[Instagram.Keys.Pagination.maxLikeId] = maxLikedId
      }
      return result

    case .recentMedia(let parameters):
      var result = InstagramRequestParameters()
      if let count = parameters.count {
        result[Instagram.Keys.Media.count] = count
      }
      if let maxId = parameters.maxId {
        result[Instagram.Keys.Pagination.maxId] = maxId
      }
      if let minId = parameters.minId {
        result[Instagram.Keys.Pagination.minId] = minId
      }
      return result

    case .search(let parameters):
      var result = InstagramRequestParameters()
      result[Instagram.Keys.Data.query] = parameters.query
      if let count = parameters.count {
        result[Instagram.Keys.Media.count] = count
      }
      return result
    }
  }
}
