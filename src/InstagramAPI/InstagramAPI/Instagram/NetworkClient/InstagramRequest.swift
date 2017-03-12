//
//  InstagramRequests.swift
//  InstagramAPI
//
//  Created by Denis on 16.01.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit
import ObjectMapper

//MARK: - Instagram 

public enum Instagram {}


//MARK: - Instagram Object

protocol InstagramObject: Mappable, Equatable {
  var objectId: String? { get }
}

extension InstagramObject {

  //MARK: - Equatable
  public static func ==(lhs: Self, rhs: Self) -> Bool {
    guard let lhsId = lhs.objectId else {
      return false
    }

    guard let rhsId = rhs.objectId else {
      return false
    }

    return lhsId == rhsId
  }
}
