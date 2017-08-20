//
//  InstagramMediaRequest+Routable.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

// MARK: - AnyNetworkRoutable

extension InstagramMediaRouter: AnyNetworkRoutable {
  // MARK: - AnyNetworkRoutable
  public var method: HTTPMethod {
    return .get
  }
  public var path: String {
    switch self {
    case let .getMedia(media):
      return "/media/\(media.pathComponent)"
    case .search:
      return "/media/search"
    }
  }
  public var parameters: InstagramRequestParameters {
    switch self {
    case .getMedia:
      return [:]
    case let .search(parameters):
      var result = InstagramRequestParameters()
      result[Instagram.Keys.Location.lat] = parameters.latitude as AnyObject?
      result[Instagram.Keys.Location.lng] = parameters.longitude as AnyObject?
      if let distance = parameters.distance {
        result[Instagram.Keys.Location.distance] = distance
      }
      return result
    }
  }
}

// MARK: - Helpers

public extension InstagramMediaRouter.MediaParameter {
  public var pathComponent: String {
    switch self {
    case .id(let id):
      return "\(id)"
    case .shortcode(let shortcode):
      return "shortcode/\(shortcode)"
    }
  }
}
