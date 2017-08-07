//
//  InstagramConstants.swift
//  ConceptOffice
//
//  Created by Denis on 24.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import Foundation
import ObjectMapper

typealias InstagramRequestParameters = [String : Any]

extension Instagram {
  enum Constants {
    static let keychainStore = "com.InstagramClient.keychainStore"
    static let baseUrl = "https://api.instagram.com/"
    static let appClientId: String = "be322b2540c745438432c86c825ed469"
    static var appRedirectURL: String {
      return SettingsManager.shared.config.instagramRedirectURL
    }
    static var baseUrlComponents: URLComponents {
      var components = URLComponents()
      components.host = "api.instagram.com"
      components.scheme = "https"
      return components
    }
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
      static let id = "id"
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
      static let options = "OPTIONS"
      static let get     = "GET"
      static let head    = "HEAD"
      static let post    = "POST"
      static let put     = "PUT"
      static let patch   = "PATCH"
      static let delete  = "DELETE"
      static let trace   = "TRACE"
      static let connect = "CONNECT"
    }
  }

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
      var result = String.emptyString
      let scopesValues = Instagram.LoginScope.scopesValues
      for scope in scopesValues {
        if scope == scopesValues.last {
          result += scope
        } else {
          result += (scope + String.spaceString)
        }
      }
      return result
    }
  }
}
