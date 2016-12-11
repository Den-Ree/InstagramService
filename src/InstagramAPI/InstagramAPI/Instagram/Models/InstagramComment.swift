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
    fileprivate(set) var from: InstagramUser?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        from <- map[kInstagramFrom]
        text <- map[kInstagramText]
        createdDate <- (map[kInstagramCreatedTime], InstagramDateTransform())
    }
}
