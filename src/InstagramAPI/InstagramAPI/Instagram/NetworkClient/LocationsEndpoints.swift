//
//  Locations.swift
//  ConceptOffice
//
//  Created by Denis on 21.02.17.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Foundation

extension Instagram {
  
  enum LocationsEndpoint {
    
    //MARK: - Requests
    
    enum Get: InstagramRequestProtocol {
      case location(id: String)
      case recentMedia(Parameter.RecentMediaParameter)
      case search(Parameter.SearchMediaParameter)
    }
    
    //MARK: - Parameters

    enum Parameter {
      struct RecentMediaParameter {
      let locationId: String
      var minId: String? = nil
      var maxId: String? = nil
    }
    
    struct SearchMediaParameter {
      var longitude: Double? = nil
      var latitude: Double? = nil
      var distance: Double? = nil
      var facebookPlacesId: String? //If Used lng/lat is not required
      }
    }
  }
}

//MARK: - InstagramRequestProtocol

extension Instagram.LocationsEndpoint.Get {
  var path: String {
    switch  self {
    case .location(id: let locationId):
      return "/locations/\(locationId)"
    case .recentMedia(let parameters):
      return "/locations\(parameters.locationId)/media/recent"
    case .search(_):
      return "/locations/search"
    }
  }
  
  var parameters: InstagramRequestParameters {
    switch self {
    case .location(id: _):
      return [:]
    case .recentMedia(let parameters):
      var result = InstagramRequestParameters()
      if let maxId = parameters.maxId{
        result[Instagram.Keys.Pagination.maxId] = maxId as AnyObject?
      }
      if let minId = parameters.minId{
        result[Instagram.Keys.Pagination.minId] = minId as AnyObject
      }
      return result
    case .search(let parameters):
      var result = InstagramRequestParameters()
      if let lng = parameters.longitude, let lat = parameters.latitude{
        result[Instagram.Keys.Location.lat] = lat as AnyObject?
        result[Instagram.Keys.Location.lng] = lng as AnyObject?
      }
      if let facebookPlacesId = parameters.facebookPlacesId{
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
