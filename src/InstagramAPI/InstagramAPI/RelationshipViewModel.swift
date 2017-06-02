//
//  RelationshipViewModel.swift
//  InstagramAPI
//
//  Created by Admin on 02.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class RelationshipViewModel : NSObject {
  
  private var type : RelationshipControllerType = .unknown
  
  init(type : RelationshipControllerType){
    self.type = type
  }
  
  func request() -> InstagramRequestProtocol?{
    switch type {
    case .follows:
      return Instagram.RelationshipsEnpoint.Request.Get.follows
      
    case .followedBy:
      return Instagram.RelationshipsEnpoint.Request.Get.followedBy
      
    case .requestedBy:
      return Instagram.RelationshipsEnpoint.Request.Get.requestedBy
      
    case .unknown:
      return nil
    }
  }
  func getDataSource(request : InstagramRequestProtocol,completion :  @escaping (([Instagram.User]?) -> ())){
    InstagramManager.shared.networkClient.send(request, completion: {
      (users : InstagramArrayResponse<Instagram.User>?, error : Error? ) in
      if error == nil{
        guard let users = users?.data  else{
          completion(nil)
          return
        }
        completion(users)
      }
    })
  }
}
