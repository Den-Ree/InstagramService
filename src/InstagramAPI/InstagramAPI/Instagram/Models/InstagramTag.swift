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
  public var name: String = ""
  public var mediaCount: Int = 0
  //swiftlint:disable:next identifier_name
  public var id: String {
    return name
  }
}
