//
//  TagMapping.swift
//  InstagramAPI
//
//  Created by Admin on 04.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
import ObjectMapper

extension InstagramCore.Models.Tag: InstagramObject{
  
  fileprivate(set) var objectId: String?
  
  public init?(map: Map) {}
  
  mutating public func mapping(map: Map) {
      objectId <- map[Instagram.Keys.Object.id]
      name <- map[Instagram.Keys.Tag.name]
      mediaCount <- map[Instagram.Keys.Tag.mediaCount]
  }

}
