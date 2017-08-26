//
//  InstagramMediaUrlTransform.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import ObjectMapper

struct InstagramMediaUrlTransform: TransformType {
  // MARK: - TransformType
  public typealias Object = InstagramMedia.Url
  public typealias JSON = [String: Any]
  public func transformFromJSON(_ value: Any?) -> Object? {
    guard
      let value = value as? JSON,
      let urlString  = value[Instagram.Keys.Data.url] as? String,
      let width = value[Instagram.Keys.Data.width] as? Double,
      let height = value[Instagram.Keys.Data.height] as? Double
      else {
      return nil
    }
    let url = URL(string: urlString)
    let size = CGSize(width: width, height: height)
    return InstagramMedia.Url(url: url, size: size)
  }
  public func transformToJSON(_ value: Object?) -> JSON? {
    guard let value = value else { return nil }
    var result = [String: Any]()
    result[Instagram.Keys.Data.url] = value.url?.absoluteString
    result[Instagram.Keys.Data.width] = value.size.width
    result[Instagram.Keys.Data.height] = value.size.height
    return result
  }
}
