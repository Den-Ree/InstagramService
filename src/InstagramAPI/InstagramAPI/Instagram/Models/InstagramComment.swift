//
//  InstagramComment.swift
//  ConceptOffice
//
//  Created by Denis on 24.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import ObjectMapper

class InstagramComment: InstagramModel {
    fileprivate(set) var createdDate: Date?
    fileprivate(set) var text: String?
    fileprivate(set) var from: Instagram.User?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        from <- map[Instagram.Keys.Comment.from]
        text <- map[Instagram.Keys.Comment.text]
        createdDate <- (map[Instagram.Keys.Object.createdTime], InstagramDateTransform())
    }
}
