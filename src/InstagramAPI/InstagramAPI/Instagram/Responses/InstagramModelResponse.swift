//
//  AnyInstagramResponse.swift
//  ConceptOffice
//
//  Created by Den Ree on 05/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Foundation

struct InstagramModelResponse <T: AnyInstagramModel>: AnyInstagramResponse {
  var data: T = T(JSON: [:])!
  var meta = InstagramMeta()
}
