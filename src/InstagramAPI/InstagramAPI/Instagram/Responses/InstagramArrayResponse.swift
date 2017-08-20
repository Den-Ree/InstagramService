//
//  InstagramArrayResponse.swift
//  ConceptOffice
//
//  Created by Den Ree on 05/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import UIKit

public struct InstagramArrayResponse <T: AnyInstagramModel>: AnyInstagramResponse {
  public var data: [T] = []
  public var meta = InstagramMeta()
  public var pagination = InstagramPaginationInfo()
}
