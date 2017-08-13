//
//  LocationsEndpoint.swift
//  ConceptOffice
//
//  Created by Kirill Averyanov on 28/05/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

enum InstagramLocationRouter: AnyInstagramNetworkRouter {
  // MARK: - Requests
  case getLocation(id: String)
  case getRecentMedia(RecentMediaParameter)
  case search(SearchMediaParameter)
  // MARK: - Parameters
  struct RecentMediaParameter {
    let locationId: String
    var minId: String?
    var maxId: String?
  }
  struct SearchMediaParameter {
    var longitude: Double?
    var latitude: Double?
    var distance: Double?
    var facebookPlacesId: String? // If Used lng/lat is not required
  }
}
