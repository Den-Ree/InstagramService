//
//  InstagramComment.swift
//  ConceptOffice
//
//  Created by Denis on 24.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import ObjectMapper

public struct InstagramComment: AnyInstagramModel {
  // MARK: - Properties
  //swiftlint:disable:next identifier_name
  public var id: String = ""
  public var createdDate = Date()
  public var text: String = ""
  public var from = InstagramUser()
}
