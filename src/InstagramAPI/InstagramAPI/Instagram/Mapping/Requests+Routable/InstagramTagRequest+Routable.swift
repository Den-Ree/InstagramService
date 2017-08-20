//
//  InstagramTagRequest+Routable.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

extension InstagramTagRouter: AnyNetworkRoutable {
  // MARK: - AnyNetworkRoutable
  public var method: HTTPMethod {
    return .get
  }
  public var path: String {
    switch self {
    case let .getTag(name):
      return "/tags/\(name)"
    case let .getRecentMedia(parameters):
      return "/tags/\(parameters.tagName)/media/recent"
    case .search:
      return "/tags/search"
    }
  }
  public var parameters: InstagramRequestParameters {
    switch self {
    case .getTag: return [:]
    case let .getRecentMedia(parameters):
      var result = InstagramRequestParameters()
      if let count = parameters.count {
        result[Instagram.Keys.Media.count]  = count as AnyObject?
      }
      if let minId = parameters.minId {
        result[Instagram.Keys.Pagination.minTagId] = minId as AnyObject?
      }
      if let maxId = parameters.maxId {
        result[Instagram.Keys.Pagination.maxTagId] = maxId as AnyObject?
      }
      return result
    case let .search(query):
      return [
        Instagram.Keys.Data.query: query as AnyObject
      ]
    }
  }
}
