//
//  InstagramComment+Mappable.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import ObjectMapper

extension InstagramComment {
  // MARK: - Mappable
  public init?(map: Map) {}
  mutating public func mapping(map: Map) {
    id <- map[Instagram.Keys.Object.id]
    from <- map[Instagram.Keys.Comment.from]
    text <- map[Instagram.Keys.Comment.text]
    createdDate <- (map[Instagram.Keys.Object.createdTime], InstagramDateTransform())
  }
}
