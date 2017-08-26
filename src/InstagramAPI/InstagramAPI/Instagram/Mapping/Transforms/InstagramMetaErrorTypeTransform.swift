//
//  InstagramMetaErrorTypeTransform.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import ObjectMapper

struct InstagramMetaErrorTypeTransform: TransformType {
  // MARK: - TransformType
  public typealias Object = InstagramMeta.ErrorType
  public typealias JSON = String
  public func transformFromJSON(_ value: Any?) -> InstagramMeta.ErrorType? {
    guard let value = value as? JSON else {
      return .empty
    }
    if let type = InstagramMeta.ErrorType(rawValue: value) {
      return type
    } else {
      assertionFailure("Detected: new meta error type - \(value)")
      return .empty
    }
  }
  public func transformToJSON(_ value: InstagramMeta.ErrorType?) -> String? {
    return value?.rawValue
  }
}
