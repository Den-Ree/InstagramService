//
//  TestConstants.swift
//  InstagramAPI
//
//  Created by Admin on 15.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
@testable import InstagramAPI

enum TestConstants {

  enum URL {
    //swiftlint:disable:next nesting
    enum User {
        static let get: String = "https://api.instagram.com/v1/users/{user-id}/?access_token=ACCESS-TOKEN"
        //swiftlint:disable:next line_length
        static let getRecent: String = "https://api.instagram.com/v1/users/{user-id}/media/recent/?access_token=ACCESS-TOKEN&count=0&max_id=0&min_id=0"
        //swiftlint:disable:next line_length
        static let getLikedMedia: String = "https://api.instagram.com/v1/users/self/media/liked?access_token=ACCESS-TOKEN&max_like_id=0&count=0"

        static let search: String = "https://api.instagram.com/v1/users/search?access_token=ACCESS-TOKEN&count=0&q=jack"
    }
    //swiftlint:disable:next nesting
    enum Relationship {
        static let getFollows: String = "https://api.instagram.com/v1/users/self/follows?access_token=ACCESS-TOKEN"
        //swiftlint:disable:next line_length
        static let getFollowedBy: String = "https://api.instagram.com/v1/users/self/followed-by?access_token=ACCESS-TOKEN"
        //swiftlint:disable:next line_length
        static let getRequestedBy: String = "https://api.instagram.com/v1/users/self/requested-by?access_token=ACCESS-TOKEN"
        //swiftlint:disable:next line_length
        static let getRelationship: String = "https://api.instagram.com/v1/users/{user-id}/relationship?access_token=ACCESS-TOKEN"

        static let post: String = "https://api.instagram.com/v1/users/{user-id}/relationship/"
    }
    //swiftlint:disable:next nesting
    enum Media {

        static let get = "https://api.instagram.com/v1/media/{media-id}?access_token=ACCESS-TOKEN"

        static let getWithShortCode = "https://api.instagram.com/v1/media/shortcode/D?access_token=ACCESS-TOKEN"
        //swiftlint:disable:next line_length
        static let search = "https://api.instagram.com/v1/media/search?access_token=ACCESS-TOKEN&lng=0&lat=0&distance=1.0"
    }
    //swiftlint:disable:next nesting
    enum Comment {

        static let get = "https://api.instagram.com/v1/media/{media-id}/comments?access_token=ACCESS-TOKEN"

        static let post = "https://api.instagram.com/v1/media/{media-id}/comments"
        //swiftlint:disable:next line_length
        static let delete = "https://api.instagram.com/v1/media/{media-id}/comments/{comment-id}?access_token=ACCESS-TOKEN"
    }
    //swiftlint:disable:next nesting
    enum Like {

        static let get = "https://api.instagram.com/v1/media/{media-id}/likes?access_token=ACCESS-TOKEN"

        static let post = "https://api.instagram.com/v1/media/{media-id}/likes"

        static let delete = "https://api.instagram.com/v1/media/{media-id}/likes?access_token=ACCESS-TOKEN"

    }
    //swiftlint:disable:next nesting
    enum Tag {

        static let get = "https://api.instagram.com/v1/tags/{tag-name}?access_token=ACCESS-TOKEN"
        //swiftlint:disable:next line_length
        static let getRecent = "https://api.instagram.com/v1/tags/{tag-name}/media/recent?access_token=ACCESS-TOKEN&min_tag_id=0&count=0&max_tag_id=0"

        static let search = "https://api.instagram.com/v1/tags/search?access_token=ACCESS-TOKEN&q=snowy"

    }
    //swiftlint:disable:next nesting
    enum Location {

        static let get = "https://api.instagram.com/v1/locations/{location-id}?access_token=ACCESS-TOKEN"
        //swiftlint:disable:next line_length
        static  let getRecent = "https://api.instagram.com/v1/locations/{location-id}/media/recent?access_token=ACCESS-TOKEN&max_id=0&min_id=0"
        //swiftlint:disable:next line_length
        static let search = "https://api.instagram.com/v1/locations/search?access_token=ACCESS-TOKEN&lng=1&lat=1&distance=1"
    }

  }

  enum HTTPBody {

      static var relationship: String {
        //swiftlint:disable:next line_length
        let parameters = [Instagram.Keys.User.Counts.action: InstagramRelationshipRouter.PostRelationshipParameter.Action.follow.rawValue]
        return parameters.parametersString()
      }

      static var comment: String {
        let parameters = [Instagram.Keys.Comment.text: "This is my comment"]
        return parameters.parametersString()
      }

      static var like: String {
        let parameters = [Instagram.Keys.Auth.accessToken: "ACCESS-TOKEN"]
        return parameters.parametersString()
      }

  }

  enum HTTPMethod {
      static let post = "POST"
      static let delete = "DELETE"
  }
}
