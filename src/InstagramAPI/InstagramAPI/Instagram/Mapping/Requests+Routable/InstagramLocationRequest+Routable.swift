//
//  InstagramLocationRequest+Routable.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

extension InstagramLocationRouter: AnyNetworkRoutable {
  // MARK: - AnyNetworkRoutable
  public var method: HTTPMethod {
    return .get
  }
  public var path: String {
    switch  self {
    case let .getLocation(id: locationId):
      return "/locations/\(locationId)"
    case let .getRecentMedia(parameters):
      return "/locations/\(parameters.locationId)/media/recent"
    case .search:
      return "/locations/search"
    }
  }
  public var parameters: InstagramRequestParameters {
    switch self {
    case .getLocation: return [:]
    case let .getRecentMedia(parameters):
      var result = InstagramRequestParameters()
      if let maxId = parameters.maxId {
        result[Instagram.Keys.Pagination.maxId] = maxId as AnyObject?
      }
      if let minId = parameters.minId {
        result[Instagram.Keys.Pagination.minId] = minId as AnyObject
      }
      return result
    case let .search(parameters):
      var result = InstagramRequestParameters()
      if let lng = parameters.longitude, let lat = parameters.latitude {
        result[Instagram.Keys.Location.lat] = lat as AnyObject?
        result[Instagram.Keys.Location.lng] = lng as AnyObject?
      }
      if let facebookPlacesId = parameters.facebookPlacesId {
        result[Instagram.Keys.Pagination.facebookPlacedId] = facebookPlacesId as AnyObject?
      }
      if let distance = parameters.distance {
        let distanceMinValue = 0.0
        let distanceMaxValue = 750.0

        if distance >= distanceMinValue && distance <= distanceMaxValue {
          result[Instagram.Keys.Location.distance] = distance as AnyObject?
        } else {
          let distanceDefaultValue = 500.0
          result[Instagram.Keys.Location.distance] = distanceDefaultValue as AnyObject?
        }
      }
      return result
    }
  }
}
