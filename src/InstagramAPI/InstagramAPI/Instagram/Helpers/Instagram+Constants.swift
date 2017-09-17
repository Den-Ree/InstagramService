//
//  InstagramConstants.swift
//  ConceptOffice
//
//  Created by Denis on 24.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import Foundation
import ObjectMapper

public typealias InstagramRequestParameters = [String : Any]

enum Instagram {}

extension Instagram {

  enum Constants {}

  public enum Keys {}

  enum LoginScope: Int {
    case basic = 0
    case publicContent
    case followerList
    case comments
    case relationships
    case likes
    static var scopesValues: [String] {
      return ["basic", "public_content", "follower_list", "comments", "relationships", "likes"]
    }
    static var allScopesValue: String {
      var result = ""
      let scopesValues = Instagram.LoginScope.scopesValues
      for scope in scopesValues {
        if scope == scopesValues.last {
          result += scope
        } else {
          result += (scope + " ")
        }
      }
      return result
    }
  }
}

extension Instagram.Constants {
  static let baseUrl = "https://api.instagram.com/"
  static var baseUrlComponents: URLComponents {
    var components = URLComponents()
    components.host = "api.instagram.com"
    components.scheme = "https"
    return components
  }
  static let grantType = "authorization_code"
}

extension Instagram.Keys {
  public enum Auth {
    public static let clientId = "client_id"
    public static let redirectUri = "redirect_uri"
    public static let accessToken = "access_token"
    public static let code = "code"
    public static let grantType = "grant_type"
    public static let clientSecret = "client_secret"
  }

  public enum Response {
    public static let type = "response_type"
    public static let token = "token"
    public static let scope = "scope"
    public static let data = "data"
    public static let meta = "meta"
    public static let pagination = "pagination"
    public static let code = "code"
  }

  public enum Object {
    //swiftlint:disable:next identifier_name
    public static let id = "id"
    public static let createdTime = "created_time"
    public static let user = "user"
  }

  public enum Error {
    public static let type = "error_type"
    public static let message = "error_message"
    public static let code = "code"
  }

  public enum User {
    //swiftlint:disable:next identifier_name
    public static let id = "id"
    public static let username = "username"
    public static let fullName = "full_name"
    public static let firstName = "first_name"
    public static let lastName = "last_name"
    public static let profilePicture = "profile_picture"
    public static let bio = "bio"
    public static let website = "website"
    public static let mediaCount = "media_count"
    public static let counts = "counts"

  }

  public enum Relationship {
    public static let outgoingStatus = "outgoing_status"
    public static let incomingStatus = "incoming_status"
  }

  public enum Media {
    public static let count = "count"
    public static let link = "link"
    public static let caption = "caption"
    public static let likes = "likes"
    public static let comments = "comments"
    public static let filter = "filter"
    public static let tags = "tags"
    public static let images = "images"
    public static let videos = "videos"
    public static let location = "location"
    public static let type = "type"
    public static let userHasLiked = "user_has_liked"
  }

  public enum Data {
    public static let image = "image"
    public static let video = "video"
    public static let thumbnail = "thumbnail"
    public static let lowResolution = "low_resolution"
    public static let standardResolution = "standard_resolution"
    public static let lowBandwidth = "low_bandwidth"
    public static let url = "url"
    public static let height = "height"
    public static let width = "width"
    public static let query = "q"
  }

  public enum Comment {
    public static let from = "from"
    public static let text = "text"
  }

  public enum Tag {
    public static let name = "name"
    public static let mediaCount = "media_count"
  }

  public enum Location {
    public static let name = "name"
    public static let latitude = "latitude"
    public static let longitude = "longitude"
    public static let streetAddress = "street_address"
    public static let lat = "lat"
    public static let lng = "lng"
    public static let distance = "distance"
  }

  public enum Pagination {
    public static let nextURL = "next_url"
    public static let nextMaxId = "next_max_id"
    public static let nextMaxLikeId = "next_max_like_id"
    public static let nextMaxTagId = "next_max_tag_id"
    public static let nextCursor = "next_cursor"
    public static let maxId = "max_id"
    public static let maxLikeId = "max_like_id"
    public static let maxTagId = "max_tag_id"
    public static let cursor = "cursor"
    public static let minTagId = "min_tag_id"
    public static let minId = "min_id"
    public static let facebookPlacedId = "facebook_placed_id"

  }

  public enum HTTPMethod {
    public static let options = "OPTIONS"
    public static let get     = "GET"
    public static let head    = "HEAD"
    public static let post    = "POST"
    public static let put     = "PUT"
    public static let patch   = "PATCH"
    public static let delete  = "DELETE"
    public static let trace   = "TRACE"
    public static let connect = "CONNECT"
  }
}

extension Instagram.Keys.User {

  public enum Counts {
    public static let media = "media"
    public static let action = "action"
    public static let follows = "follows"
    public static let followedBy = "followed_by"
  }

}
