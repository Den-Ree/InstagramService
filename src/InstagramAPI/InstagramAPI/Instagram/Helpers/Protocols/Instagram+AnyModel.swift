//
//  InstagramRequest.swift
//  ConceptOffice
//
//  Created by Kirill Averyanov on 24/05/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import UIKit
import ObjectMapper

// MARK: - Instagram Object
public protocol AnyInstagramModel: Mappable, Equatable {
  //swiftlint:disable:next identifier_name
  var id: String { get }
}

public extension AnyInstagramModel {
  // MARK: - Equatable
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.id == rhs.id
  }
}
