//
//  RelationshipMapping.swift
//  InstagramAPI
//
//  Created by Admin on 04.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
import ObjectMapper


public struct InstagramRelationship: InstagramObject{
  
    fileprivate(set) var outgoingStatus: String?
    fileprivate(set) var incomingStatus: String?
    fileprivate(set) var objectId: String?
  
}


public extension InstagramRelationship{
  
  
    mutating public func mapping(map: Map) {
      objectId <- map[Instagram.Keys.Object.id]
      outgoingStatus <- map["outgoing_status"]
      incomingStatus <- map["incoming_status"]
    }
  
    //MARK: Mappable
    public init?(map: Map) {}
}
