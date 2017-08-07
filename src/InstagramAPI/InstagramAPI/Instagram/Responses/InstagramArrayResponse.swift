//
//  InstagramArrayResponse.swift
//  ConceptOffice
//
//  Created by Den Ree on 05/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import UIKit

struct InstagramArrayResponse <T: AnyInstagramModel>: AnyInstagramResponse {
  var data: [T] = []
  var meta = InstagramMeta()
  var pagination = InstagramPaginationInfo()
}
