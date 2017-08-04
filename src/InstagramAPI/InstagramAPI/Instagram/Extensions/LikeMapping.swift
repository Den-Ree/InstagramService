//
//  LikeMapping.swift
//  InstagramAPI
//
//  Created by Admin on 04.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
import ObjectMapper

extension InstagramCore.Models.Like: InstagramObject{
  
  fileprivate(set) var objectId: String?
  
  public init?(map: Map){}
  
  mutating public func mapping(map: Map) {
      objectId <- map[Instagram.Keys.Object.id]
      username <- map[Instagram.Keys.User.username]
      firstName <- map[Instagram.Keys.User.firstName]
      lastName <- map[Instagram.Keys.User.lastName]
      type <- map[Instagram.Keys.Media.type]
  }
}
