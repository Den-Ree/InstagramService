//
//  UserMapping.swift
//  InstagramAPI
//
//  Created by Admin on 04.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
import ObjectMapper

public struct InstagramUser: InstagramObject{
  
   fileprivate(set) var username: String?
   fileprivate(set) var fullName: String?
   fileprivate(set) var profilePictureURL: URL?
   fileprivate(set) var bio: String?
   fileprivate(set) var website: URL?
   fileprivate(set) var counts: UserCounts?
   fileprivate(set) var objectId: String?
}



extension InstagramUser{

    public init?(map: Map) {}
  
    mutating public func mapping(map: Map) {
      objectId <- map[Instagram.Keys.Object.id]
      username <- map[Instagram.Keys.User.username]
      fullName <- map[Instagram.Keys.User.fullName]
      profilePictureURL <- (map[Instagram.Keys.User.profilePicture], URLTransform())
      bio <- map[Instagram.Keys.User.bio]
      website <- (map[Instagram.Keys.User.website], URLTransform())
      counts <- (map[Instagram.Keys.User.counts], InstagramUserCountsTransform())
    }
}


public struct UserCounts {
  
    //MARK: - Properties
    fileprivate(set) var media: Int = 0
    fileprivate(set) var follows: Int = 0
    fileprivate(set) var followedBy: Int = 0
}
