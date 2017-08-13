//
//  InstagramTag.swift
//  ConceptOffice
//
//  Created by Denis on 24.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import ObjectMapper

struct InstagramTag: AnyInstagramModel {
  // MARK: - Properties
  var name: String = ""
  var mediaCount: Int = 0
  var id: String {
    return name
  }
}
