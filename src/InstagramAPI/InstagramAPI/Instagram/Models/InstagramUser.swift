//
//  InstagramUser.swift
//  ConceptOffice
//
//  Created by Denis on 23.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import ObjectMapper

public struct InstagramUserCounts {
    
    //MARK: Properties
    fileprivate(set) var media: Int = 0
    fileprivate(set) var follows: Int = 0
    fileprivate(set) var followedBy: Int = 0
}

class InstagramUser: InstagramModel {
    
    //MARK: Properties
    fileprivate(set) var username: String?
    fileprivate(set) var fullName: String?
    fileprivate(set) var profilePictureURL: URL?
    fileprivate(set) var bio: String?
    fileprivate(set) var website: URL?
    fileprivate(set) var counts: InstagramUserCounts?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        username <- map[kInstagramUsername]
        fullName <- map[kInstagramFullName]
        profilePictureURL <- (map[kInstagramProfilePicture], URLTransform())
        bio <- map[kInstagramBio]
        website <- (map[kInstagramWebsite], URLTransform())
        counts <- (map[kInstagramCounts], InstagramUserCountsTransform())
    }
}

/**
Base data of user, who follows current user
 */
class InstagramFollower: InstagramModel {
    fileprivate(set) var username: String?
    fileprivate(set) var fullName: String?
    fileprivate(set) var profilePictureURL: URL?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        username <- map[kInstagramUsername]
        fullName <- map[kInstagramFullName]
        profilePictureURL <- (map[kInstagramProfilePicture], URLTransform())
    }
}