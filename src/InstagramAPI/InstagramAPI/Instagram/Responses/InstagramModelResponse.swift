//
//  AnyInstagramResponse.swift
//  ConceptOffice
//
//  Created by Den Ree on 05/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Foundation

public struct InstagramModelResponse <T: AnyInstagramModel>: AnyInstagramResponse {
  public var data: T = T(JSON: [:])!
  public var meta = InstagramMeta()
}
