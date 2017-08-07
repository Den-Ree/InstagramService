//
//  CommentMapping.swift
//  InstagramAPI
//
//  Created by Admin on 04.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
import ObjectMapper

public struct InstagramComment: InstagramObject {
  
     fileprivate(set) var createdDate: Date?
     fileprivate(set) var text: String?
     fileprivate(set) var from: InstagramUser
     fileprivate(set) var objectId: String
}



extension InstagramComment{

  public init?(map: Map) {}
  
  mutating public func mapping(map: Map) {
      objectId <- map[Instagram.Keys.Object.id]
      from <- map[Instagram.Keys.Comment.from]
      text <- map[Instagram.Keys.Comment.text]
      createdDate <- (map[Instagram.Keys.Object.createdTime], InstagramDateTransform())
  }

}
