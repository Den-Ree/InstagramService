//
//  LocationMappingf.swift
//  InstagramAPI
//
//  Created by Admin on 04.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
import ObjectMapper

extension InstagramCore.Models.Location: InstagramObject{
  
  var objectId: String?
  
  public init?(map: Map) {}
  
  //MARK: Mappable
  mutating public func mapping(map: Map) {
    objectId <- map[Instagram.Keys.Object.id]
    latitude <- map[Instagram.Keys.Location.latitude]
    longitude <- map[Instagram.Keys.Location.longitude]
    streetAddress <- map[Instagram.Keys.Location.streetAddress]
    name <- map[Instagram.Keys.Location.name]
  }
  
}
