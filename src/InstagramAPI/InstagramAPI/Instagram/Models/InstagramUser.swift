//
//  InstagramUser.swift
//  ConceptOffice
//
//  Created by Denis on 23.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import ObjectMapper

struct InstagramUser: AnyInstagramModel {
  // MARK: - Nested
  struct Counts {
    var media: Int = 0
    var follows: Int = 0
    var followedBy: Int = 0
  }
  // MARK: - Properties
  var id: String = ""
  var username: String = ""
  var fullName: String = ""
  var profilePictureUrl: URL? = nil
  var bio: String = ""
  var website: String = ""
  var counts = Counts()
}
