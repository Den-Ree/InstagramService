//
//  LocationsEndpoints.swift
//  InstagramAPI
//
//  Created by Admin on 03.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation

extension InstagramEndpoints{
  
  enum LocationsEndpoint {
    
    //MARK: - Requests
    
    enum Get{
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
