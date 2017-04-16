//
//  InstagramConstants.swift
//  ConceptOffice
//
//  Created by Denis on 24.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import Foundation
import ObjectMapper

typealias InstagramPaginationRange = CountableRange<Int>
typealias InstagramErrorBlock = (Error?)->()
typealias InstagramSuccessBlock = (Bool, Error?)->()

//MARK: Path
typealias InstagramURLPath = String

let instagramAuthorizationURLPath: InstagramURLPath = "https://api.instagram.com/oauth/authorize/"


//MARK: Request Keys
typealias InstagramRequestKey = String
typealias InstagramRequestParameters = [InstagramRequestKey : Any]
typealias InstagramResponseKey = String


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
        static let action = "action"
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
      static let query = "q"
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
      static let lat = "lat"
      static let lng = "lng"
      static let distance = "distance"
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
      static let minTagId = "min_tag_id"
      static let minId = "min_id"
      static let facebookPlacedId = "facebook_placed_id"
      
    }
    
    enum HTTPMethod {
      static let get     = "GET"
      static let post    = "POST"
      static let delete  = "DELETE"
    }
    
    enum Notifications {
      static let noLoggedInAccounts = "InstagramManagerNoLoggedInAccountsNotification"
      static let mediaWasChanged = "InstagramManagerMediaDidChangedNotification"
      static let accessTokenExpired = "InstagramManagerMediaAccessTokenExpired"
    }

    
  }
  
}

extension Instagram.Keys{
  
  enum Network{
    static let scheme = "https"
    static let host = "api.instagram.com"
    static let path = "/v1"
    static let authorizationPath = "/oauth/authorize/"
  }
  
  
}
extension Instagram{
  enum Values{
    enum AuthValues{
      static let appClientId: String = "eb6961971b7149899a3692a4125bb6af"
      static var appRedirectURL: String = "https://www.nolisto.com"
    }
  }
}




enum InstagramLoginScope: Int {
    case basic = 0
    case publicContent
    case followerList
    case comments
    case relationships
    case likes
    
    static var scopesValues: [InstagramRequestKey] {
        return ["basic", "public_content", "follower_list", "comments", "relationships", "likes"]
    }
    
    static var allScopesValue: InstagramRequestKey {
        var result = String.emptyString
        let scopesValues = InstagramLoginScope.scopesValues
        for scope in scopesValues {
            if scope == scopesValues.last {
                result += scope
            }
            else {
                result += (scope + String.spaceString)
            }
        }
        
        return result
    }
}

//Media URL
typealias InstagramMediaURLDictionary = [String: AnyObject]

public struct InstagramMediaURL {
    fileprivate(set) var URL: Foundation.URL?
    fileprivate(set) var size: CGSize = CGSize.zero
    
    init(mediaURLDictionary: InstagramMediaURLDictionary?) {
        if let urlString = mediaURLDictionary?[Instagram.Keys.Data.url] as? String, let url = Foundation.URL(string: urlString), let width = mediaURLDictionary?[Instagram.Keys.Data.width] as? CGFloat, let height = mediaURLDictionary?[Instagram.Keys.Data.height] as? CGFloat {
            self.URL = url
            self.size = CGSize(width: width, height: height)
        }
    }
    
    //MARK: Public
    func convertToDictionary() -> InstagramMediaURLDictionary? {
        var result = InstagramMediaURLDictionary()
        if let urlString = URL?.absoluteString {
            result[Instagram.Keys.Data.url] = urlString as AnyObject?
        }
        
        result[Instagram.Keys.Data.width] = size.width as AnyObject?
        result[Instagram.Keys.Data.height] = size.height as AnyObject?
        return result
    }
}

//Media
typealias InstagramImagesDictionary = [String: AnyObject]

public struct InstagramImage {
  
    fileprivate(set) var lowResolutionURL: InstagramMediaURL?
    fileprivate(set) var standardResolutionURL: InstagramMediaURL?
    fileprivate(set) var thumbnailURL: InstagramMediaURL?
}

//Video
typealias InstagramVideosDictionary = [String: AnyObject]

public struct InstagramVideo {
  
    fileprivate(set) var lowResolutionURL: InstagramMediaURL?
    fileprivate(set) var standardResolutionURL: InstagramMediaURL?
    fileprivate(set) var lowBandwidthURL: InstagramMediaURL?
}

open class InstagramUserCountsTransform: TransformType {
    public typealias Object = Instagram.UserCounts
    public typealias JSON = [String: Int]
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Instagram.UserCounts? {
        if let dictionary = value as? [String: Int] {
            if let media = dictionary[Instagram.Keys.User.Counts.media], let follows = dictionary[Instagram.Keys.User.Counts.follows], let followedBy = dictionary[Instagram.Keys.User.Counts.followedBy] {
                return Instagram.UserCounts(media: media, follows: follows, followedBy: followedBy)
            }
        }
        return nil
    }
    
    open func transformToJSON(_ value: Instagram.UserCounts?) -> [String: Int]? {
        if let counts = value {
            return [Instagram.Keys.User.Counts.media: counts.media, Instagram.Keys.User.Counts.follows: counts.follows, Instagram.Keys.User.Counts.followedBy: counts.followedBy]
        }
        return nil
    }
}

open class InstagramImageTransform: TransformType {
    public typealias Object = InstagramImage
    public typealias JSON = [String: AnyObject]
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> InstagramImage? {
        guard let images = value as? InstagramImagesDictionary else {
            return nil
        }
        
        let lowResolutionURL = InstagramMediaURL(mediaURLDictionary: images[Instagram.Keys.Data.lowResolution] as? InstagramMediaURLDictionary)
        let standardResolutionURL = InstagramMediaURL(mediaURLDictionary: images[Instagram.Keys.Data.standardResolution] as? InstagramMediaURLDictionary)
        let thumbnailURL = InstagramMediaURL(mediaURLDictionary: images[Instagram.Keys.Data.thumbnail] as? InstagramMediaURLDictionary)
        
        return InstagramImage(lowResolutionURL: lowResolutionURL, standardResolutionURL: standardResolutionURL, thumbnailURL: thumbnailURL)
    }
    
    open func transformToJSON(_ value: InstagramImage?) -> [String: AnyObject]? {
        guard let image = value else {
            return nil
        }
        
        var imagesDictionary = InstagramImagesDictionary()
        if let lowResolutionURL = image.lowResolutionURL {
            imagesDictionary[Instagram.Keys.Data.lowResolution] = lowResolutionURL.convertToDictionary() as AnyObject?
        }
        
        if let standardResolution = image.standardResolutionURL {
            imagesDictionary[Instagram.Keys.Data.standardResolution] = standardResolution.convertToDictionary() as AnyObject?
        }
        
        if let thumbnailURL = image.thumbnailURL {
            imagesDictionary[Instagram.Keys.Data.thumbnail] = thumbnailURL.convertToDictionary() as AnyObject?
        }
        
        return imagesDictionary
    }
}

open class InstagramVideoTransform: TransformType {
    public typealias Object = InstagramVideo
    public typealias JSON = [String: AnyObject]
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> InstagramVideo? {
        guard let videos = value as? InstagramVideosDictionary else {
            return nil
        }
        
        let lowResolutionURL = InstagramMediaURL(mediaURLDictionary: videos[Instagram.Keys.Data.lowResolution] as? InstagramMediaURLDictionary)
        let standardResolutionURL = InstagramMediaURL(mediaURLDictionary: videos[Instagram.Keys.Data.standardResolution] as? InstagramMediaURLDictionary)
        let lowBandwidthURL = InstagramMediaURL(mediaURLDictionary: videos[Instagram.Keys.Data.lowBandwidth] as? InstagramMediaURLDictionary)
        
        return InstagramVideo(lowResolutionURL: lowResolutionURL, standardResolutionURL: standardResolutionURL, lowBandwidthURL: lowBandwidthURL)
    }
    
    open func transformToJSON(_ value: InstagramVideo?) -> [String: AnyObject]? {
        guard let video = value else {
            return nil
        }
        
        var videosDictionary = InstagramVideosDictionary()
        if let lowResolutionURL = video.lowResolutionURL {
            videosDictionary[Instagram.Keys.Data.lowResolution] = lowResolutionURL.convertToDictionary() as AnyObject?
        }
        
        if let standardResolution = video.standardResolutionURL {
            videosDictionary[Instagram.Keys.Data.standardResolution] = standardResolution.convertToDictionary() as AnyObject?
        }
        
        if let lowBandwidthURL = video.lowBandwidthURL {
            videosDictionary[Instagram.Keys.Data.lowBandwidth] = lowBandwidthURL.convertToDictionary() as AnyObject?
        }
        
        return videosDictionary
    }
}

open class InstagramDateTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let value = value as? String, let timeInterval = Double(value) {
            return Date(timeIntervalSince1970: timeInterval)
        }
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return "\(date.timeIntervalSince1970)"
        }
        return nil
    }
}
