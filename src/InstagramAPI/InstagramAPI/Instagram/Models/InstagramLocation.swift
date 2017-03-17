//
//  InstagramLocation.swift
//  ConceptOffice
//
//  Created by Denis on 28.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import ObjectMapper

public extension Instagram {
  
  //MARK: - Location
  
  struct Location: InstagramObject{
    
    //MARK: Properties
    fileprivate(set) var latitude: Double?
    fileprivate(set) var longitude: Double?
    fileprivate(set) var streetAddress: String?
    fileprivate(set) var name: String?
    fileprivate(set) var objectId: String?
    
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
}
