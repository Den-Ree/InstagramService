//
//  LikesEndpoints.swift
//  InstagramAPI
//
//  Created by Admin on 03.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation

extension InstagramCore.Endpoints{
  
  enum LikesEndpoint {
    
    //MARK: - Requests
    
    enum Request {
      
      enum Get{
        case likes(mediaId: String)
      }
      
      enum Post{
        case likes(mediaId: String)
      }
      
      enum Delete{
        case likes(mediaId: String)
      }
    }
    
    //MARK: - Parameters
    
    enum Parameter {
      struct DeleteLikeParameter {
        let mediaId: String
        let commentId: String
      }
    }
  }
}
