//
//  InstagramTag.swift
//  ConceptOffice
//
//  Created by Denis on 24.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import ObjectMapper

class InstagramTag: InstagramModel {
    
    //MARK: Properties
    fileprivate(set) var name: String = ""
    fileprivate(set) var mediaCount: Int = 0
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map[Instagram.Keys.Tag.name]
        mediaCount <- map[Instagram.Keys.Tag.mediaCount]
    }
}

extension InstagramTag {
    //Force init
    static func create(_ name: String, mediaCount: Int) -> InstagramTag? {
        let tag = InstagramTag(JSON: [Instagram.Keys.Tag.name: name, Instagram.Keys.Tag.mediaCount: mediaCount])
        return tag
    }
}
