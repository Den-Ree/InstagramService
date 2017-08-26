//
//  InstagramMedia+Mappable.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import ObjectMapper

public extension InstagramMedia {
  // MARK: - Mappable
  init?(map: Map) {}
  mutating func mapping(map: Map) {
    id <- map[Instagram.Keys.Object.id]
    user <- map[Instagram.Keys.Object.user]
    userHasLiked <- map[Instagram.Keys.Media.userHasLiked]
    createdDate <- (map[Instagram.Keys.Object.createdTime], InstagramDateTransform())
    link <- (map[Instagram.Keys.Media.link])
    caption <- map[Instagram.Keys.Media.caption]
    tagsCount <- map[Instagram.Keys.Media.tags + "." + Instagram.Keys.Media.count]
    likesCount <- map[Instagram.Keys.Media.likes + "." + Instagram.Keys.Media.count]
    commentsCount <- map[Instagram.Keys.Media.comments + "." + Instagram.Keys.Media.count]
    image <- map[Instagram.Keys.Media.images]

    video <- map[Instagram.Keys.Media.videos]
    type <- (map[Instagram.Keys.Media.type], InstagramMediaTypeTransform())
    tags <- map[Instagram.Keys.Media.tags]
  }
}

// MARK: - InstagramImage

extension InstagramMedia.Image: Mappable {
  // MARK: - Mappable
  public init?(map: Map) {}
  mutating public func mapping(map: Map) {
    lowResolution <- (map[Instagram.Keys.Data.lowResolution], InstagramMediaUrlTransform())
    standardResolution <- (map[Instagram.Keys.Data.standardResolution], InstagramMediaUrlTransform())
    thumbnail <- (map[Instagram.Keys.Data.thumbnail], InstagramMediaUrlTransform())
  }
}

// MARK: - InstagramVideo

public extension InstagramMedia.Video {
  // MARK: - Mappable
  public init?(map: Map) {}
  mutating public func mapping(map: Map) {
    lowResolution <- (map[Instagram.Keys.Data.lowResolution], InstagramMediaUrlTransform())
    standardResolution <- (map[Instagram.Keys.Data.standardResolution], InstagramMediaUrlTransform())
    lowBandwidth <- (map[Instagram.Keys.Data.lowBandwidth], InstagramMediaUrlTransform())
  }
}
