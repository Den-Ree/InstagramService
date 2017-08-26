//
//  InstagramDateTransform.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import ObjectMapper

struct InstagramDateTransform: TransformType {
  // MARK: - TransformType
  public typealias Object = Date
  public typealias JSON = String
  public func transformFromJSON(_ value: Any?) -> Date? {
    if let value = value as? JSON, let timeInterval = Double(value) {
      return Date(timeIntervalSince1970: timeInterval)
    }
    return nil
  }
  public func transformToJSON(_ value: Date?) -> String? {
    if let date = value {
      return "\(date.timeIntervalSince1970)"
    }
    return nil
  }
}
