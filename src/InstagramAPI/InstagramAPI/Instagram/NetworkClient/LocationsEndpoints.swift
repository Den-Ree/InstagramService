//
//  Locations.swift
//  ConceptOffice
//
//  Created by Denis on 21.02.17.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

extension Instagram {
  
  enum LocationsEndpoint {
    
    //Requests
    enum Get: InstagramRequestProtocol {
      case location(id: String)
      case recentMedia(RecentMediaParameter)
      case search(SearchMediaParameter)
    }
    
    //Params
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
        result["lat"] = lat as AnyObject?
        result["lng"] = lng as AnyObject?
      }
      if let facebookPlacesId = parameters.facebookPlacesId{
        result["facebook_placed_id"] = facebookPlacesId as AnyObject?
      }
      if let distance = parameters.distance {
        let distanceMinValue = 0.0
        let distanceMaxValue = 750.0
        
        if distance >= distanceMinValue && distance <= distanceMaxValue {
          result["distance"] = distance as AnyObject?
        } else {
          let distanceDefaultValue = 500.0
          result["distance"] = distanceDefaultValue as AnyObject?
        }
      }
      return result
    }
  }
}
