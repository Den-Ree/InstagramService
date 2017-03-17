//
//  InstagramComment.swift
//  ConceptOffice
//
//  Created by Denis on 24.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import ObjectMapper

public extension Instagram {
  
  //MARK: - Comment
  
  struct Comment : InstagramObject {
    
    //MARK: - Properties
    
    fileprivate(set) var createdDate: Date?
    fileprivate(set) var text: String?
    fileprivate(set) var from: Instagram.User?
    fileprivate(set) var objectId: String?
    
    public init?(map: Map) {}
    
    //MARK: Mappable
    mutating public func mapping(map: Map) {
      objectId <- map[Instagram.Keys.Object.id]
      from <- map[Instagram.Keys.Comment.from]
      text <- map[Instagram.Keys.Comment.text]
      createdDate <- (map[Instagram.Keys.Object.createdTime], InstagramDateTransform())
    }
  }
}

