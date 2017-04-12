//
//  Media.swift
//  ConceptOffice
//
//  Created by Denis on 21.02.17.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Foundation

extension Instagram {
  
  enum MediaEndpoint {
    
    //MARK: - Requests
    
    enum Get: InstagramRequestProtocol {
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

//MARK: - InstagramRequestProtocol

extension Instagram.MediaEndpoint.Parameter.Media {
  var pathComponent: String {
    switch self {
    case .id(let id):
      return "\(id)"
    case .shortcode(let shortcode):
      return "shortcode/\(shortcode)"
    }
  }
}

extension Instagram.MediaEndpoint.Get {
  var path: String {
    switch self {
    case .media(let media):
      return "/media/\(media.pathComponent)"
      
    case .search(_):
      return "media/search"
    }
  }
  
  var parameters: InstagramRequestParameters {
    switch self {
    case .media(_):
      return [:]
    case .search(let parameters):
      
      var result = InstagramRequestParameters()
      
      result[Instagram.Keys.Location.lat] = parameters.latitude as AnyObject?
      result[Instagram.Keys.Location.lng] = parameters.longitude as AnyObject?
      if let distance = parameters.distance {
        result[Instagram.Keys.Location.distance] = distance
      }
      return result
    }
  }
}
