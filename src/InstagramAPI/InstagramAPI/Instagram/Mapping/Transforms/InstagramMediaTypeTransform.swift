//
//  InstagramMediaTypeTransform.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import ObjectMapper

struct InstagramMediaTypeTransform: TransformType {
  // MARK: - TransformType
  public typealias Object = InstagramMedia.MediaType
  public typealias JSON = String
  public func transformFromJSON(_ value: Any?) -> InstagramMedia.MediaType? {
    guard let value = value as? JSON else {
      return .image
    }
    if let type = InstagramMedia.MediaType(rawValue: value) {
      return type
    } else {
      assertionFailure("Detected: new media type - \(value)")
      return .image
    }
  }
  public func transformToJSON(_ value: InstagramMedia.MediaType?) -> JSON? {
    return value?.rawValue
  }
}
