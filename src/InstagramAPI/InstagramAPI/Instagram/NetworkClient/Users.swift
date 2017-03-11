//
//  Users.swift
//  ConceptOffice
//
//  Created by Denis on 21.02.17.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

extension Instagram {
  
  public enum UsersEndpoint {
    
    //Requests
    enum Get: InstagramRequestProtocol {
      case user(User)
      case recentMedia(RecentMediaParameter)
      case likedMedia(LikedMediaParameter)
      case search(SearchUserParameter)
    }
    
    //Parameters
    struct SearchUserParameter {
      let query: String
      var count: Int? = nil
      
      init(query: String, count: Int) {
        self.query = query
        self.count = count
      }
    }
    
    struct LikedMediaParameter {
      let user: User
      var count: Int?
      var maxLikeId: String?
      
      init(user: User, count: Int, maxLikeId: String) {
        self.user = user
        self.count = count
        self.maxLikeId = maxLikeId
      }
    }
    
    struct RecentMediaParameter {
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
      case id(InstagramObjectId)
      case owner
      
      init(_ userId: InstagramObjectId? = nil) {
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


//MARK: Users endpoints extensions
extension Instagram.UsersEndpoint.User {
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
      return [
        Instagram.Keys.Media.count         : parameters.count as AnyObject,
        Instagram.Keys.Pagination.maxLikeId   : parameters.maxLikeId as AnyObject
      ]
    case .recentMedia(let parameters):
      return [
        Instagram.Keys.Media.count     : parameters.count as AnyObject,
        Instagram.Keys.Pagination.maxId    : parameters.maxId as AnyObject,
        "min_id"    : parameters.minId as AnyObject
      ]
    case .search(let parameters):
      return [
        "q"     : parameters.query as AnyObject,
        Instagram.Keys.Media.count : parameters.count as AnyObject
      ]
    }
  }
}
