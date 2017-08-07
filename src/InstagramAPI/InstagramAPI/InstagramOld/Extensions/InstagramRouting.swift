//
//  InstagramRouter.swift
//  InstagramAPI
//
//  Created by Admin on 03.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
import Alamofire

protocol Requestable{
  
    var path: String {get}
    var parameters: InstagramRequestParameters {get}
    var method: HTTPMethod {get}
    var bodyObject: NetworkBodyObject? {get}
  
}

enum Routing{
  
  case get
  case post
  case delete
  
}





// How to give a type of final request to type of Endpoint
class InstagramRouter: NSObject{
 
  var type: InstagramCore.Endpoints.Type
  
  init(type: InstagramCore.Endpoints.Type){
    
    self.type = type
    
  }
  
  
  
}

