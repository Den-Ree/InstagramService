//
//  UserEndpoints.swift
//  InstagramAPI
//
//  Created by Admin on 03.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
  
public enum InstagramEndpoints{}
  


extension InstagramEndpoints {
  
  public enum UsersEndpoint {
    
    //MARK: - Requests
    
    enum Get{
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
