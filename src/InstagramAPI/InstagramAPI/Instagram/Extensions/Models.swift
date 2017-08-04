//
//  Models.swift
//  InstagramAPI
//
//  Created by Admin on 03.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
import ObjectMapper

extension InstagramModels{
  
  public struct User: InstagramObject{
    
      var username: String?
      var fullName: String?
      var profilePictureURL: URL?
      var bio: String?
      var website: URL?
      var counts: InstagramModels.UserCounts?
      var objectId: String?
    }
  
  
    
   public struct UserCounts: InstagramObject {
      
      var media: Int = 0
      var follows: Int = 0
      var followedBy: Int = 0
      var objectId: String?
      
    }

  
  public struct Relationship: InstagramObject{
    
      var outgoingStatus: String?
      var incomingStatus: String?
      var objectId: String?
      
    }
  
  public struct Media: InstagramObject{
    
      public enum MediaType: String {
        case image = "image"
        case video = "video"
      }
    
      var user: InstagramModels.User?
      var userHasLiked: Bool?
      var createdDate: Date?
      var link: URL?
      var caption: InstagramModels.Comment?
      var tagsCount: Int = 0
      var likesCount: Int = 0
      var commentsCount: Int = 0
      var location: InstagramModels.Location?
      var type: String?
      var image: InstagramImage?
      var video: InstagramVideo?
      var tags: [String]?
      var objectId: String?
    
      var isVideo: Bool {
        return type == MediaType.video.rawValue
      }

    }
  
  public struct Comment: InstagramObject{
    
      var createdDate: Date?
      var text: String?
      var from: InstagramModels.User
      var objectId: String?
    }
  
  public struct Like: InstagramObject{
    
      var username: String?
      var firstName: String?
      var lastName: String?
      var type: String?
      var objectId: String?
    }
  
  public struct Tag: InstagramObject{
    
      var name: String = ""
      var mediaCount: Int = 0
      var objectId: String?
    
      //Force init
      static func create(_ name: String, mediaCount: Int) -> InstagramModels.Tag? {
        let tag = InstagramModels.Tag(JSON: [Instagram.Keys.Tag.name: name, Instagram.Keys.Tag.mediaCount: mediaCount])
        return tag
      }

    }
  
  public struct Location: InstagramObject{
    
      var latitude: Double?
      var longitude: Double?
      var streetAddress: String?
      var name: String?
      var objectId: String?
    }
}
