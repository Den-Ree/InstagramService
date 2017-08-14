//
//  MediaEndpoint.swift
//  ConceptOffice
//
//  Created by Kirill Averyanov on 28/05/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

enum InstagramMediaRouter: AnyInstagramNetworkRouter {
  // MARK: - Requests
  case getMedia(MediaParameter)
  case search(SearchMediaParameter)
  // MARK: - Parameters
  struct SearchMediaParameter {
    let longitude: Double
    let latitude: Double
    var distance: Double?
  }
  enum MediaParameter {
    case id(String)
    case shortcode(String)
  }
}
