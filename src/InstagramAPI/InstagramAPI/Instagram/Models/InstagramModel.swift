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
         objectId <- map[kInstagramObjectId]
    }
}
