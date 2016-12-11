//
//  InstagramLike.swift
//  ConceptOffice
//
//  Created by Denis on 03.04.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import ObjectMapper

class InstagramLike: InstagramModel {
    
    //MARK: Properties
    fileprivate(set) var username: String?
    fileprivate(set) var firstName: String?
    fileprivate(set) var lastName: String?
    fileprivate(set) var type: String?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        username <- map[kInstagramUsername]
        firstName <- map[kInstagramFirstName]
        lastName <- map[kInstagramLastName]
        type <- map[kInstagramType]
    }
}
