//
//  InstagramMedia.swift
//  ConceptOffice
//
//  Created by Denis on 23.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import ObjectMapper
import CoreLocation

class InstagramMedia: InstagramModel {
    
    enum MediaType: String {
        case Image = "image"
        case Video = "video"
    }
    
    //MARK: Properties
    fileprivate(set) var user: Instagram.User?
    fileprivate(set) var userHasLiked: Bool?
    fileprivate(set) var createdDate: Date?
    fileprivate(set) var link: URL?
    fileprivate(set) var caption: InstagramComment?
    fileprivate(set) var tagsCount: Int = 0
    fileprivate(set) var likesCount: Int = 0
    fileprivate(set) var commentsCount: Int = 0
    fileprivate(set) var location: InstagramLocation?
    fileprivate(set) var type: String?
    fileprivate(set) var image: InstagramImage?
    fileprivate(set) var video: InstagramVideo?
    fileprivate(set) var tags: [String]?
    
    var isVideo: Bool {
        return type == MediaType.Video.rawValue
    }
    
    //MARK: Protected
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        user <- map[Instagram.Keys.Object.user]
        userHasLiked <- map[Instagram.Keys.Media.userHasLiked]
        createdDate <- (map[Instagram.Keys.Object.createdTime], InstagramDateTransform())
        link <- (map[Instagram.Keys.Media.link], URLTransform())
        caption <- map[Instagram.Keys.Media.caption]
        tagsCount <- map[Instagram.Keys.Media.tags + String.dotString + Instagram.Keys.Media.count]
        likesCount <- map[Instagram.Keys.Media.likes + String.dotString + Instagram.Keys.Media.count]
        commentsCount <- map[Instagram.Keys.Media.comments + String.dotString + Instagram.Keys.Media.count]
        image <- (map[Instagram.Keys.Media.images], InstagramImageTransform())
        video <- (map[Instagram.Keys.Media.videos], InstagramVideoTransform())
        type <- map[Instagram.Keys.Media.type]
        tags <- map[Instagram.Keys.Media.tags]
    }
}
