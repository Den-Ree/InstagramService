//
//  InstagramDataTransform.swift
//  InstagramAPI
//
//  Created by Admin on 04.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
import ObjectMapper

open class InstagramDateTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
  
    public init() {}
  
    open func transformFromJSON(_ value: Any?) -> Date? {
      if let value = value as? String, let timeInterval = Double(value) {
        return Date(timeIntervalSince1970: timeInterval)
      }
      return nil
  }
  
    open func transformToJSON(_ value: Date?) -> String? {
      if let date = value {
        return "\(date.timeIntervalSince1970)"
      }
      return nil
  }
}
