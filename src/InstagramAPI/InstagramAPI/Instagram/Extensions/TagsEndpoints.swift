//
//  TagsEndpoints.swift
//  InstagramAPI
//
//  Created by Admin on 03.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation

extension InstagramCore.Endpoints{
  enum TagsEndpoint {
    
    //MARK: - Requests
    
    enum Get{
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
