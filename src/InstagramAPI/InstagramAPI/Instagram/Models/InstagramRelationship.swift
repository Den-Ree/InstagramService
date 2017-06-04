//
//  InstagramRelationship.swift
//  InstagramAPI
//
//  Created by Admin on 03.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit
import ObjectMapper

public extension Instagram{
  
  //MARK: - Relationship
  
  struct Relationship: InstagramObject {
    
    //MARK: - Properties
    fileprivate(set) var outgoingStatus: String?
    fileprivate(set) var incomingStatus: String?
    fileprivate(set) var objectId: String?
    
    mutating public func mapping(map: Map) {
      objectId <- map[Instagram.Keys.Object.id]
      outgoingStatus <- map["outgoing_status"]
      incomingStatus <- map["incoming_status"]
    }

    //MARK: Mappable
    public init?(map: Map) {}
    
  }
}
