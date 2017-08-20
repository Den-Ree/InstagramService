//
//  TagsEndpoint.swift
//  ConceptOffice
//
//  Created by Kirill Averyanov on 28/05/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

public  enum InstagramTagRouter: AnyInstagramNetworkRouter {
  // MARK: - Requests
  case getTag(name: String)
  case getRecentMedia(RecentMediaParameter)
  case search(query: String)
  // MARK: - Parameters
  //Parameters
  /**
   @params A valid access token.
   - maxId: Return media after this max_tag_id.
   - count: Count of tagged media to return.
   - minId: Return media before this min_tag_id.
   */
  public struct RecentMediaParameter {
    public let tagName: String
    public var minId: String?
    public var maxId: String?
    public var count: Int?
  }
}
