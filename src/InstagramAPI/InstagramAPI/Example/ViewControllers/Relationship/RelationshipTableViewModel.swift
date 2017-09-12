//
//  RelationshipViewModel.swift
//  InstagramAPI
//
//  Created by Admin on 02.06.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

class RelationshipTableViewModel: NSObject {

  private var type: RelationshipTableControllerType = .unknown

  init(type: RelationshipTableControllerType) {
    self.type = type
  }

  func request() -> AnyInstagramNetworkRouter? {
      switch type {
      case .follows:
        return InstagramRelationshipRouter.getFollows

      case .followedBy:
        return InstagramRelationshipRouter.getFollowedBy

      case .requestedBy:
        return InstagramRelationshipRouter.getRequestedBy

      case .unknown:
        return nil
      }
  }
  func getDataSource(request: AnyInstagramNetworkRouter, completion:  @escaping (([InstagramUser]?) -> Void)) {
      InstagramClient().send(request, completion: {(users: InstagramArrayResponse<InstagramUser>?, error: Error? ) in
        if error == nil {
          guard let users = users?.data  else {
            completion(nil)
            return
          }
          completion(users)
        }
      })
    }
}
