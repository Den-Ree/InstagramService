//
//  InstagramLocation.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import ObjectMapper

public extension InstagramLocation {
  // MARK: - Mappable
  init?(map: Map) {}
  mutating func mapping(map: Map) {
    latitude <- map[Instagram.Keys.Location.latitude]
    longitude <- map[Instagram.Keys.Location.longitude]
    streetAddress <- map[Instagram.Keys.Location.streetAddress]
    name <- map[Instagram.Keys.Location.name]
  }
}
