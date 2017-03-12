//
//  Instagram+Constants.swift
//  ConceptOffice
//
//  Created by Denis on 18.02.17.
//  Copyright © 2017 Den Ree. All rights reserved.
//
extension Instagram {
  enum Constants {
    static let keychainStore = "com.InstagramManager.keychainStore"
  }
  
  enum Keys {
    
    enum Auth {
      static let clientId = "client_id"
      static let redirectUri = "redirect_uri"
      static let accessToken = "access_token"
    }
    
    enum Response {
      static let type = "response_type"
      static let token = "token"
      static let scope = "scope"
      static let data = "data"
      static let meta = "meta"
      static let pagination = "pagination"
    }
    
    enum Object {
      static let id = "id"
      static let createdTime = "created_time"
      static let user = "user"
    }
    
    enum Error {
      static let type = "error_type"
      static let message = "error_message"
      static let code = "code"
    }
    
    enum User {
      static let username = "username"
      static let fullName = "full_name"
      static let firstName = "first_name"
      static let lastName = "last_name"
      static let profilePicture = "profile_picture"
      static let bio = "bio"
      static let website = "website"
      static let mediaCount = "media_count"
      static let counts = "counts"
      
      enum Counts {
        static let media = "media"
        static let follows = "follows"
        static let followedBy = "followed_by"
      }
    }
    
    enum Media {
      static let count = "count"
      static let link = "link"
      static let caption = "caption"
      static let likes = "likes"
      static let comments = "comments"
      static let filter = "filter"
      static let tags = "tags"
      static let images = "images"
      static let videos = "videos"
      static let location = "location"
      static let type = "type"
      static let userHasLiked = "user_has_liked"
    }
    
    enum Data {
      static let image = "image"
      static let video = "video"
      static let thumbnail = "thumbnail"
      static let lowResolution = "low_resolution"
      static let standardResolution = "standard_resolution"
      static let lowBandwidth = "low_bandwidth"
      static let url = "url"
      static let height = "height"
      static let width = "width"
    }
    
    enum Comment {
      static let from = "from"
      static let text = "text"
    }
    
    enum Tag {
      static let name = "name"
      static let mediaCount = "media_count"
    }
    
    enum Location {
      
      static let name = "name"
      static let latitude = "latitude"
      static let longitude = "longitude"
      static let streetAddress = "street_address"
    }
    
    enum Pagination {
      static let nextURL = "next_url"
      static let nextMaxId = "next_max_id"
      static let nextMaxLikeId = "next_max_like_id"
      static let nextMaxTagId = "next_max_tag_id"
      static let nextCursor = "next_cursor"
      static let maxId = "max_id"
      static let maxLikeId = "max_like_id"
      static let maxTagId = "max_tag_id"
      static let cursor = "cursor"
    }
  }
}
