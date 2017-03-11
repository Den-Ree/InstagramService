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
        username <- map[Instagram.Keys.User.username]
        firstName <- map[Instagram.Keys.User.firstName]
        lastName <- map[Instagram.Keys.User.lastName]
        type <- map[Instagram.Keys.Media.type]
    }
}
