//
//  InstagramComment.swift
//  ConceptOffice
//
//  Created by Denis on 24.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import ObjectMapper

struct InstagramComment: AnyInstagramModel {
  // MARK: - Properties
  var id: String = ""
  var createdDate = Date()
  var text: String = ""
  var from = InstagramUser()
}
