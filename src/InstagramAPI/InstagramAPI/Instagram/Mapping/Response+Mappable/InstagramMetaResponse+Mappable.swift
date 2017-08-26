//
//  InstagramMetaResponse+Mappable.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import ObjectMapper

extension InstagramMetaResponse {
  // MARK: - Mappable
  public init?(map: Map) {}
  mutating public func mapping(map: Map) {
    meta <- map[Instagram.Keys.Response.meta]
  }
}

extension InstagramMeta: Mappable {
  // MARK: - Mappable
  public init?(map: Map) {}
  mutating public func mapping(map: Map) {
    code <- map[Instagram.Keys.Error.code]
    errorType <- (map[Instagram.Keys.Error.type], InstagramMetaErrorTypeTransform())
    errorMessage <- map[Instagram.Keys.Error.message]
  }
}
