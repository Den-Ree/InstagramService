//
//  InstagramTag.swift
//  ConceptOffice
//
//  Created by Denis on 24.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import ObjectMapper

public extension Instagram{
  
  //MARK: - Tag

  struct Tag : InstagramObject {
    
    //MARK: Properties
    fileprivate(set) var name: String = ""
    fileprivate(set) var mediaCount: Int = 0
    fileprivate(set) var objectId: String?
    
    public init?(map: Map) {}
    
    //MARK: Mappable
    mutating public func mapping(map: Map) {
      objectId <- map[Instagram.Keys.Object.id]
      name <- map[Instagram.Keys.Tag.name]
      mediaCount <- map[Instagram.Keys.Tag.mediaCount]
    }
  }
}
public extension Instagram.Tag {
    //Force init
    static func create(_ name: String, mediaCount: Int) -> Instagram.Tag? {
        let tag = Instagram.Tag(JSON: [Instagram.Keys.Tag.name: name, Instagram.Keys.Tag.mediaCount: mediaCount])
        return tag
    }
}
