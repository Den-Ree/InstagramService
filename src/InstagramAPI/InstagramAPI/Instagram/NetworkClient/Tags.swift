//
//  Tags.swift
//  ConceptOffice
//
//  Created by Denis on 21.02.17.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

extension Instagram {
  
  enum TagsEndpoint {
    
    
    //Requests
    enum Get: InstagramRequestProtocol {
      case tag(name: String)
      case recentMedia(RecentMediaParameter)
      case search(query: String)
    }
    
    
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
  
  var parameters: [String: Any] {
    switch self {
    case .tag(_):
      return [:]
    case .recentMedia(let parameters):
      var result = [String : Any]()
      if let count = parameters.count {
        result["count"]  = count
      }
      if let minId = parameters.minId {
        result["min_tag_id"] = minId
      }
      if let maxId = parameters.maxId {
        result["max_tag_id"] = maxId
      }
      return result
    case .search(let query):
      return [
        "q": query
      ]
    }
  }
}
