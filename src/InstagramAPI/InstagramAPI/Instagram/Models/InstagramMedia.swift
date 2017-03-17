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

public extension Instagram{
  
  //MARK: - Media
  
  struct Media : InstagramObject {
    
    //MARK: - Properties
    
    fileprivate(set) var user: Instagram.User?
    fileprivate(set) var userHasLiked: Bool?
    fileprivate(set) var createdDate: Date?
    fileprivate(set) var link: URL?
    fileprivate(set) var caption: Instagram.Comment?
    fileprivate(set) var tagsCount: Int = 0
    fileprivate(set) var likesCount: Int = 0
    fileprivate(set) var commentsCount: Int = 0
    fileprivate(set) var location: Instagram.Location?
    fileprivate(set) var type: String?
    fileprivate(set) var image: InstagramImage?
    fileprivate(set) var video: InstagramVideo?
    fileprivate(set) var tags: [String]?
    fileprivate(set) var objectId: String?
    
    var isVideo: Bool {
      return type == MediaType.video.rawValue
    }
    
    //MARK: Mappable
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map){
      objectId <- map[Instagram.Keys.Object.id]
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
  
  public enum MediaType: String {
    case image = "image"
    case video = "video"
  }
  
}

