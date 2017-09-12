//
//  InstagramLocation.swift
//  ConceptOffice
//
//  Created by Denis on 28.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import ObjectMapper

public struct InstagramLocation: AnyInstagramModel {
  // MARK: - Properties
  public var latitude: Double = 0
  public var longitude: Double = 0
  public var streetAddress: String = ""
  public var name: String = ""
  //swiftlint:disable:next identifier_name
  public var id: String = ""
}
