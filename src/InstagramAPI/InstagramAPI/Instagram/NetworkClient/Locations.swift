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
      let locationId: InstagramObjectId
      var minId: String? = nil
      var maxId: String? = nil
    }
    
    struct SearchMediaParameter {
      var longitude: Double? = nil
      var latitude: Double? = nil
      var distance: Double? = nil
      var facebookPlacesId: InstagramObjectId? //If Used lng/lat is not required
    }
  }
}

extension Instagram.LocationsEndpoint.Get {
  var path: String {
    //TODO: Need to fill
    return ""
  }
  
  var parameters: [String: Any] {
    //TODO: Need to fill
    return [:]
  }
}
