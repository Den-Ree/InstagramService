//
//  InstagramLike.swift
//  ConceptOffice
//
//  Created by Denis on 03.04.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import ObjectMapper

public extension Instagram {
  
  //MARK: - Like
  
  struct Like : InstagramObject{
    
    //MARK: Properties
    
    fileprivate(set) var username: String?
    fileprivate(set) var firstName: String?
    fileprivate(set) var lastName: String?
    fileprivate(set) var type: String?
    fileprivate(set) var objectId: String?
   
    public init?(map: Map){}
    
    //MARK: Mappable
    mutating public func mapping(map: Map) {
      objectId <- map[Instagram.Keys.Object.id]
      username <- map[Instagram.Keys.User.username]
      firstName <- map[Instagram.Keys.User.firstName]
      lastName <- map[Instagram.Keys.User.lastName]
      type <- map[Instagram.Keys.Media.type]
    }
  }
}
