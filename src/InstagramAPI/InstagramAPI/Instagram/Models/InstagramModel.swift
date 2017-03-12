//
//  InstagramModel.swift
//  ConceptOffice
//
//  Created by Denis on 23.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import ObjectMapper

class InstagramModel: NSObject, Mappable {
    
    //MARK: Properties
    //The unique identifier for each model object.
    fileprivate(set) var objectId: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
         objectId <- map[Instagram.Keys.Object.id]
    }
    
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
