//
//  Instagram+Mapping.swift
//  ConceptOffice
//
//  Created by Den Ree on 28/07/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import ObjectMapper

public extension InstagramUser {
  // MARK: - Mappable
  init?(map: Map) {}
  mutating func mapping(map: Map) {
    id <- map[Instagram.Keys.Object.id]
    username <- map[Instagram.Keys.User.username]
    fullName <- map[Instagram.Keys.User.fullName]
    profilePictureUrl <- (map[Instagram.Keys.User.profilePicture], URLTransform())
    bio <- map[Instagram.Keys.User.bio]
    website <- map[Instagram.Keys.User.website]
    counts <- map[Instagram.Keys.User.counts]
  }
}

// MARK: - Counts

extension InstagramUser.Counts {
  // MARK: - Mappable
  init?(map: Map) {}
  mutating func mapping(map: Map) {
    media <- map[Instagram.Keys.User.Counts.media]
    follows <- map[Instagram.Keys.User.Counts.follows]
    followedBy <- map[Instagram.Keys.User.Counts.followedBy]
  }
}
