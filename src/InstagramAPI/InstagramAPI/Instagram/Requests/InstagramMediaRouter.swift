//
//  MediaEndpoint.swift
//  ConceptOffice
//
//  Created by Kirill Averyanov on 28/05/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

public enum InstagramMediaRouter: AnyInstagramNetworkRouter {
  // MARK: - Requests
  case getMedia(MediaParameter)
  case search(SearchMediaParameter)
  // MARK: - Parameters
  public struct SearchMediaParameter {
    public let longitude: Double
    public let latitude: Double
    public var distance: Double?
  }
  public enum MediaParameter {
    //swiftlint:disable:next identifier_name
    case id(String)
    case shortcode(String)
  }
}
