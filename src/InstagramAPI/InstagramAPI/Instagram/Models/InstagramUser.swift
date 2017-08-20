//
//  InstagramUser.swift
//  ConceptOffice
//
//  Created by Denis on 23.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import ObjectMapper

public struct InstagramUser: AnyInstagramModel {
  // MARK: - Nested
  public struct Counts {
    public var media: Int = 0
    public var follows: Int = 0
    public var followedBy: Int = 0
  }
  // MARK: - Properties
  public var id: String = ""
  public var username: String = ""
  public var fullName: String = ""
  public var profilePictureUrl: URL? = nil
  public var bio: String = ""
  public var website: String = ""
  public var counts = Counts()
}
