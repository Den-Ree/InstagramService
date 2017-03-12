//
//  InstagramUser.swift
//  ConceptOffice
//
//  Created by Denis on 23.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import ObjectMapper

public extension Instagram {

  //MARK: - User

  struct User: InstagramObject {

    //MARK: - Properties
    fileprivate(set) var username: String?
    fileprivate(set) var fullName: String?
    fileprivate(set) var profilePictureURL: URL?
    fileprivate(set) var bio: String?
    fileprivate(set) var website: URL?
    fileprivate(set) var counts: Instagram.UserCounts?
    fileprivate(set) var objectId: String?

    //MARK: Mappable
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

  //MARK: - UserCounts

  public struct UserCounts {

    //MARK: - Properties
    fileprivate(set) var media: Int = 0
    fileprivate(set) var follows: Int = 0
    fileprivate(set) var followedBy: Int = 0
  }
}


