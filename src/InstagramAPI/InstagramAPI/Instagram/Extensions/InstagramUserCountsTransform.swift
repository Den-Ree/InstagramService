//
//  InstagramUserCountsTransform.swift
//  InstagramAPI
//
//  Created by Admin on 04.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
import ObjectMapper


open class InstagramUserCountsTransform: TransformType {
  public typealias Object = InstagramModels.UserCounts
  public typealias JSON = [String: Int]
  
  public init() {}
  
  open func transformFromJSON(_ value: Any?) -> InstagramModels.UserCounts? {
    if let dictionary = value as? [String: Int] {
      if let media = dictionary[Instagram.Keys.User.Counts.media], let follows = dictionary[Instagram.Keys.User.Counts.follows], let followedBy = dictionary[Instagram.Keys.User.Counts.followedBy] {
        return InstagramModels.UserCounts(media: media, follows: follows, followedBy: followedBy)
      }
    }
    return nil
  }
  
  open func transformToJSON(_ value: InstagramModels.UserCounts?) -> [String: Int]? {
    if let counts = value {
      return [Instagram.Keys.User.Counts.media: counts.media, Instagram.Keys.User.Counts.follows: counts.follows, Instagram.Keys.User.Counts.followedBy: counts.followedBy]
    }
    return nil
  }
}
