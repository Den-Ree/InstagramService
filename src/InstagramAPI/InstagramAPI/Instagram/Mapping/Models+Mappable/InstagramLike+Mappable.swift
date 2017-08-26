//
//  InstagramLike+Mappable.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import ObjectMapper

extension InstagramLike {
  // MARK: - Mappable
  public init?(map: Map) {}
  mutating public func mapping(map: Map) {
    username <- map[Instagram.Keys.User.username]
    firstName <- map[Instagram.Keys.User.firstName]
    lastName <- map[Instagram.Keys.User.lastName]
    type <- map[Instagram.Keys.Media.type]
  }
}
