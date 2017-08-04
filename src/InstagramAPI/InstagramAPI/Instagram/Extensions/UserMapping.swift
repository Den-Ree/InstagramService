//
//  UserMapping.swift
//  InstagramAPI
//
//  Created by Admin on 04.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
import ObjectMapper


extension InstagramModels.User{

  
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
