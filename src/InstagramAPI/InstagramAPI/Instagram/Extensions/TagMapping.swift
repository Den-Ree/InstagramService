//
//  TagMapping.swift
//  InstagramAPI
//
//  Created by Admin on 04.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
import ObjectMapper

public struct InstagramTag: InstagramObject{
  
     fileprivate(set) var name: String = ""
     fileprivate(set) var mediaCount: Int = 0
     fileprivate(set) var objectId: String?
  
  //Force init
  static func create(_ name: String, mediaCount: Int) -> InstagramTag? {
     let tag = InstagramTag(JSON: [Instagram.Keys.Tag.name: name, Instagram.Keys.Tag.mediaCount: mediaCount])
      return tag
   }
}




extension InstagramTag{
  
  
  public init?(map: Map) {}
  
  mutating public func mapping(map: Map) {
      objectId <- map[Instagram.Keys.Object.id]
      name <- map[Instagram.Keys.Tag.name]
      mediaCount <- map[Instagram.Keys.Tag.mediaCount]
  }

}
