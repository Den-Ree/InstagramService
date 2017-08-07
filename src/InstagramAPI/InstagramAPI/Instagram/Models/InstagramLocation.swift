//
//  InstagramLocation.swift
//  ConceptOffice
//
//  Created by Denis on 28.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import ObjectMapper

struct InstagramLocation: AnyInstagramModel {
  // MARK: - Properties
  var latitude: Double = 0
  var longitude: Double = 0
  var streetAddress: String = ""
  var name: String = ""
  var id: String = ""
}
