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
    fileprivate(set) var user: InstagramUser?
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
        user <- map[kInstagramUser]
        userHasLiked <- map[kInstagramUserHasLiked]
        createdDate <- (map[kInstagramCreatedTime], InstagramDateTransform())
        link <- (map[kInstagramLink], URLTransform())
        caption <- map[kInstagramCaption]
        tagsCount <- map[kInstagramTags + String.dotString + kInstagramCount]
        likesCount <- map[kInstagramLikes + String.dotString + kInstagramCount]
        commentsCount <- map[kInstagramComments + String.dotString + kInstagramCount]
        image <- (map[kInstagramImages], InstagramImageTransform())
        video <- (map[kInstagramVideos], InstagramVideoTransform())
        type <- map[kInstagramType]
        tags <- map[kInstagramTags]
    }
}
