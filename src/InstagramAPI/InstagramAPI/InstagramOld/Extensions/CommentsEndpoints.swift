//
//  CommentsEndpoints.swift
//  InstagramAPI
//
//  Created by Admin on 03.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation

extension InstagramEndpoints{
  
  enum CommentsEndpoint {
    
    //MARK: - Requests
    
    enum Request {
      
      enum Get{
        case comment(mediaId: String)
      }
      
      enum Post{
        case comment(Parameter.PostCommentParameter)
      }
      
      enum Delete{
        case comment(Parameter.DeleteCommentParameter)
      }
      
    }
    
    
    //MARK: - Parameters
    
    enum Parameter {
      
      struct DeleteCommentParameter {
        let mediaId: String
        let commentId: String
      }
      
      struct PostCommentParameter {
        let mediaId: String
        let text: String
        //TODO: Need to create typealis and return error if string is not supports
        /**
         The total length of the comment cannot exceed 300 characters.
         The comment cannot contain more than 4 hashtags.
         The comment cannot contain more than 1 URL.
         The comment cannot consist of all capital letters.
         */
      }
      
    }
  }
}
