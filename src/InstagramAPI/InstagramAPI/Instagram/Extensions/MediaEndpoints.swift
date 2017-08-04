//
//  MediaEndpoints.swift
//  InstagramAPI
//
//  Created by Admin on 03.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation

extension InstagramEndpoints{
  
  enum MediaEndpoint {
    
    //MARK: - Requests
    
    enum Get{
      case media(Parameter.Media)
      case search(Parameter.SearchMediaParameter)
    }
    
    //MARK: - Parameters
    
    /**
     @params A valid access token.
     - distance: Default is 1km (distance=1000), max distance is 5km.
     - longitude: Longitude of the center search coordinate. If used, lat is required.
     - latitude: Latitude of the center search coordinate. If used, lng is required.
     */
    
    enum Parameter {
      
      struct SearchMediaParameter {
        let longitude: Double
        let latitude: Double
        var distance: Double? = nil
      }
      
      enum Media {
        case id(String)
        case shortcode(String)
      }
    }
  }
}
