//
//  InstagramObject+Utilities.swift
//  InstagramAPI
//
//  Created by Denis on 22.03.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

extension InstagramObject {
  //TODO: naming?
  func listPropertiesWithValues(reflect: Mirror? = nil) {
    let mirror = reflect ?? Mirror(reflecting: self)
    if mirror.superclassMirror != nil {
      self.listPropertiesWithValues(reflect: mirror.superclassMirror)
    }
    for (index, attr) in mirror.children.enumerated() {
      if let property_name = attr.label as String! {
        print("|\(mirror.description) \(index): \(property_name): \(attr.value)")
      }
    }
  }
}
