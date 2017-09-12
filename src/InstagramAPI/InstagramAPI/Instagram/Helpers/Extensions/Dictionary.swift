//
//  Dictionary.swift
//  InstagramAPI
//
//  Created by Admin on 04.09.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation

extension Dictionary {

  func parametersString() -> String {
    var paramsString = [String]()
    for (key, value) in self {
      guard let stringValue = value as? String, let stringKey = key as? String else {
        return ""
      }
      paramsString += [stringKey + "=" + "\(stringValue)"]
    }
    return (paramsString.isEmpty ? "" : paramsString.joined(separator: "&"))
  }
}
