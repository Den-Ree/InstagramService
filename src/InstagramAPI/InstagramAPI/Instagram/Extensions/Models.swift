//
//  Models.swift
//  InstagramAPI
//
//  Created by Admin on 03.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation

extension InstagramCore.Models{
  enum Models{
    
    struct User{
    
      //MARK: - Properties
      fileprivate(set) var username: String?
      fileprivate(set) var fullName: String?
      fileprivate(set) var profilePictureURL: URL?
      fileprivate(set) var bio: String?
      fileprivate(set) var website: URL?
      fileprivate(set) var counts: Instagram.UserCounts?
      fileprivate(set) var objectId: String?
    
    }
  
    struct Relationship{
    
        //MARK: - Properties
      fileprivate(set) var outgoingStatus: String?
      fileprivate(set) var incomingStatus: String?
      fileprivate(set) var objectId: String?
    
    }
  
    struct Media{
    
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
    }
  
    struct Comment{
    
      //MARK: - Properties
    
      fileprivate(set) var createdDate: Date?
      fileprivate(set) var text: String?
      fileprivate(set) var from: Instagram.User?
      fileprivate(set) var objectId: String?

    }
  
    struct Like{
    
      //MARK: Properties
    
      fileprivate(set) var username: String?
      fileprivate(set) var firstName: String?
      fileprivate(set) var lastName: String?
      fileprivate(set) var type: String?
      fileprivate(set) var objectId: String?
    }
  
    struct Tag{
    
      //MARK: Properties
      fileprivate(set) var name: String = ""
      fileprivate(set) var mediaCount: Int = 0
      fileprivate(set) var objectId: String?
    }
  
    struct Location{
    
      //MARK: Properties
      fileprivate(set) var latitude: Double?
      fileprivate(set) var longitude: Double?
      fileprivate(set) var streetAddress: String?
      fileprivate(set) var name: String?
      fileprivate(set) var objectId: String?
    }
  }
}
