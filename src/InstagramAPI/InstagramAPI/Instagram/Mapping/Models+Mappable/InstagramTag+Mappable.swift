//
//  InstagramTag+Mappable.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import ObjectMapper

extension InstagramTag {
  // MARK: - Mappable
  public init?(map: Map) {}
  mutating public func mapping(map: Map) {
    name <- map[Instagram.Keys.Tag.name]
    mediaCount <- map[Instagram.Keys.Tag.mediaCount]
  }
}
