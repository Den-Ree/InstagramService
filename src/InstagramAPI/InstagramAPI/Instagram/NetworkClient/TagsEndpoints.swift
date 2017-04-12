//
//  Tags.swift
//  ConceptOffice
//
//  Created by Denis on 21.02.17.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Foundation

extension Instagram {
  
  enum TagsEndpoint {
    
    //MARK: - Requests
    
    enum Get: InstagramRequestProtocol {
      case tag(name: String)
      case recentMedia(Parameter.RecentMediaParameter)
      case search(query: String)
    }
    
    //MARK: - Parameters
    
    enum Parameter {
      //Parameters
      /**
       @params A valid access token.
       - maxId: Return media after this max_tag_id.
       - count: Count of tagged media to return.
       - minId: Return media before this min_tag_id.
       */
      struct RecentMediaParameter {
        let tagName: String
        var minId: String? = nil
        var maxId: String? = nil
        var count: Int? = nil
      }
    }
  }
}

//MARK: - InstagramRequestProtocol

extension Instagram.TagsEndpoint.Get {
  var path: String {
    switch self {
    case .tag(let name):
      return "/tags/\(name)"
    case .recentMedia(let parameters):
      return "/tags/\(parameters.tagName)/media/recent"
    case .search(_):
      return "/tags/search"
    }
  }
  
  var parameters: InstagramRequestParameters {
    switch self {
    case .tag(_):
      return [:]
    case .recentMedia(let parameters):
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
    case .search(let query):
      return [
        Instagram.Keys.Data.query : query as AnyObject
      ]
    }
  }
}
