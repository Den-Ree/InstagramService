//
//  InstagramRelationship+Mappable.swift
//  InstagramAPI
//
//  Created by Admin on 09.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import ObjectMapper

extension InstagramRelationship{
  
  public init?(map: Map) {}
  mutating public func mapping(map: Map) {
    id <- map[Instagram.Keys.Object.id]
    outgoingStatus <- map[Instagram.Keys.Relationship.outgoingStatus]
    incomingStatus <- map[Instagram.Keys.Relationship.incomingStatus]
  }
}
