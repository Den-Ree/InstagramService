//
//  InstagramModelResponse+Mappable.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import ObjectMapper

extension InstagramModelResponse {
  // MARK: - Mappable
  public init?(map: Map) {}
  mutating public func mapping(map: Map) {
    data <- map[Instagram.Keys.Response.data]
    meta <- map[Instagram.Keys.Response.meta]
  }
}
