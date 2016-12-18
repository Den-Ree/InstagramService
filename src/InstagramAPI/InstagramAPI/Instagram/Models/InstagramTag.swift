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
        name <- map[kInstagramName]
        mediaCount <- map[kInstagramMediaCount]
    }
}

extension InstagramTag {
    //Force init
    static func create(_ name: String, mediaCount: Int) -> InstagramTag? {
        let tag = InstagramTag(JSON: [kInstagramName: name, kInstagramMediaCount: mediaCount])
        return tag
    }
}
