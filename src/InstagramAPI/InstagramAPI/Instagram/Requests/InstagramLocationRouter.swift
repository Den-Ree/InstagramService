//
//  LocationsEndpoint.swift
//  ConceptOffice
//
//  Created by Kirill Averyanov on 28/05/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

public enum InstagramLocationRouter: AnyInstagramNetworkRouter {
  // MARK: - Requests
  case getLocation(id: String)
  case getRecentMedia(RecentMediaParameter)
  case search(SearchMediaParameter)
  // MARK: - Parameters
  public struct RecentMediaParameter {
    public let locationId: String
    public var minId: String?
    public var maxId: String?
  }
  public struct SearchMediaParameter {
    public var longitude: Double?
    public var latitude: Double?
    public var distance: Double?
    public var facebookPlacesId: String? // If Used lng/lat is not required
  }
}
