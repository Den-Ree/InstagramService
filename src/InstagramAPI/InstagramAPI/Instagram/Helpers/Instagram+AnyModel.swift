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
protocol AnyInstagramModel: Mappable, Equatable {
  var id: String { get }
}

extension AnyInstagramModel {
  // MARK: - Equatable
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.id == rhs.id
  }
}
