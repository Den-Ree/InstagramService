//
//  Instagram+AnyResponse.swift
//  ConceptOffice
//
//  Created by Den Ree on 05/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import ObjectMapper

public protocol AnyInstagramResponse: Mappable {
  var meta: InstagramMeta { get }
}
