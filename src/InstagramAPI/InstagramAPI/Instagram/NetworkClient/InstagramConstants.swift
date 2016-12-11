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

let instagramBaseURLPath: InstagramURLPath = "https://api.instagram.com/v1"
let instagramAuthorizationURLPath: InstagramURLPath = "https://api.instagram.com/oauth/authorize/"


//MARK: Request Keys
typealias InstagramRequestKey = String
typealias InstagramRequestParameters = [InstagramRequestKey : AnyObject]


let kInstagramCliendId = "client_id"
let kInstagramRedirectUri = "redirect_uri"
let kInstagramResponseType = "response_type"
let kInstagramToken = "token"
let kInstagramScope = "scope"
let kInstagramAccessToken = "access_token"

//MARK: Response Keys
typealias InstagramResponseKey = String

let kInstagramObjectId = "id"
let kInstagramCount = "count"
let kInstagramURL = "url"
let kInstagramHeight = "height"
let kInstagramWidth = "width"

let kInstagramData = "data"
let kInstagramMeta = "meta"
let kInstagramPagination = "pagination"
let kInstagramCode = "code"
let kInstagramErrorType = "error_type"
let kInstagramErrorMessage = "error_message"

let kInstagramThumbnail = "thumbnail"
let kInstagramLowResolution = "low_resolution"
let kInstagramStandardResolution = "standard_resolution"
let kInstagramLowBandwidth = "low_bandwidth"

let kInstagramImage = "image"
let kInstagramVideo = "video"

let kInstagramUser = "user"
let kInstagramUserHasLiked = "user_has_liked"
let kInstagramCreatedTime = "created_time"
let kInstagramLink = "link"
let kInstagramCaption = "caption"
let kInstagramLikes = "likes"
let kInstagramComments = "comments"
let kInstagramFilter = "filter"

let kInstagramTags = "tags"
let kInstagramImages = "images"
let kInstagramVideos = "videos"
let kInstagramLocation = "location"
let kInstagramType = "type"

let kInstagramFrom = "from"
let kInstagramText = "text"

let kInstagramUsername = "username"
let kInstagramFullName = "full_name"
let kInstagramFirstName = "first_name"
let kInstagramLastName = "last_name"
let kInstagramProfilePicture = "profile_picture"
let kInstagramBio = "bio"
let kInstagramWebsite = "website"

let kInstagramCounts = "counts"
let kInstagramMedia = "media"
let kInstagramFollows = "follows"
let kInstagramFollowedBy = "followed_by"

let kInstagramMediaCount = "media_count"

let kInstagramName = "name"
let kInstagramLatitude = "latitude"
let kInstagramLongitude = "longitude"
let kInstagramStreetAddress = "street_address"

let kInstagramNextURL = "next_url"
let kInstagramNextMaxId = "next_max_id"
let kInstagramNextMaxLikeId = "next_max_like_id"
let kInstagramNextMaxTagId = "next_max_tag_id"
let kInstagramNextCursor = "next_cursor"

let kInstagramMaxId = "max_id"
let kInstagramMaxLikeId = "max_like_id"
let kInstagramMaxTagId = "max_tag_id"
let kInstagramCursor = "cursor"


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
        if let urlString = mediaURLDictionary?[kInstagramURL] as? String, let url = Foundation.URL(string: urlString), let width = mediaURLDictionary?[kInstagramWidth] as? CGFloat, let height = mediaURLDictionary?[kInstagramHeight] as? CGFloat {
            self.URL = url
            self.size = CGSize(width: width, height: height)
        }
    }
    
    //MARK: Public
    func convertToDictionary() -> InstagramMediaURLDictionary? {
        var result = InstagramMediaURLDictionary()
        if let urlString = URL?.absoluteString {
            result[kInstagramURL] = urlString as AnyObject?
        }
        
        result[kInstagramWidth] = size.width as AnyObject?
        result[kInstagramHeight] = size.height as AnyObject?
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
    public typealias Object = InstagramUserCounts
    public typealias JSON = [String: Int]
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> InstagramUserCounts? {
        if let dictionary = value as? [String: Int] {
            if let media = dictionary[kInstagramMedia], let follows = dictionary[kInstagramFollows], let followedBy = dictionary[kInstagramFollowedBy] {
                return InstagramUserCounts(media: media, follows: follows, followedBy: followedBy)
            }
        }
        return nil
    }
    
    open func transformToJSON(_ value: InstagramUserCounts?) -> [String: Int]? {
        if let counts = value {
            return [kInstagramMedia: counts.media, kInstagramFollows: counts.follows, kInstagramFollowedBy: counts.followedBy]
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
        
        let lowResolutionURL = InstagramMediaURL(mediaURLDictionary: images[kInstagramLowResolution] as? InstagramMediaURLDictionary)
        let standardResolutionURL = InstagramMediaURL(mediaURLDictionary: images[kInstagramStandardResolution] as? InstagramMediaURLDictionary)
        let thumbnailURL = InstagramMediaURL(mediaURLDictionary: images[kInstagramThumbnail] as? InstagramMediaURLDictionary)
        
        return InstagramImage(lowResolutionURL: lowResolutionURL, standardResolutionURL: standardResolutionURL, thumbnailURL: thumbnailURL)
    }
    
    open func transformToJSON(_ value: InstagramImage?) -> [String: AnyObject]? {
        guard let image = value else {
            return nil
        }
        
        var imagesDictionary = InstagramImagesDictionary()
        if let lowResolutionURL = image.lowResolutionURL {
            imagesDictionary[kInstagramLowResolution] = lowResolutionURL.convertToDictionary() as AnyObject?
        }
        
        if let standardResolution = image.standardResolutionURL {
            imagesDictionary[kInstagramStandardResolution] = standardResolution.convertToDictionary() as AnyObject?
        }
        
        if let thumbnailURL = image.thumbnailURL {
            imagesDictionary[kInstagramThumbnail] = thumbnailURL.convertToDictionary() as AnyObject?
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
        
        let lowResolutionURL = InstagramMediaURL(mediaURLDictionary: videos[kInstagramLowResolution] as? InstagramMediaURLDictionary)
        let standardResolutionURL = InstagramMediaURL(mediaURLDictionary: videos[kInstagramStandardResolution] as? InstagramMediaURLDictionary)
        let lowBandwidthURL = InstagramMediaURL(mediaURLDictionary: videos[kInstagramLowBandwidth] as? InstagramMediaURLDictionary)
        
        return InstagramVideo(lowResolutionURL: lowResolutionURL, standardResolutionURL: standardResolutionURL, lowBandwidthURL: lowBandwidthURL)
    }
    
    open func transformToJSON(_ value: InstagramVideo?) -> [String: AnyObject]? {
        guard let video = value else {
            return nil
        }
        
        var videosDictionary = InstagramVideosDictionary()
        if let lowResolutionURL = video.lowResolutionURL {
            videosDictionary[kInstagramLowResolution] = lowResolutionURL.convertToDictionary() as AnyObject?
        }
        
        if let standardResolution = video.standardResolutionURL {
            videosDictionary[kInstagramStandardResolution] = standardResolution.convertToDictionary() as AnyObject?
        }
        
        if let lowBandwidthURL = video.lowBandwidthURL {
            videosDictionary[kInstagramLowBandwidth] = lowBandwidthURL.convertToDictionary() as AnyObject?
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
