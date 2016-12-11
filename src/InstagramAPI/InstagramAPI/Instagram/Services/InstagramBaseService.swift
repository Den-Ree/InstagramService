//
//  InstagramBaseService.swift
//  ConceptOffice
//
//  Created by Denis on 27.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit

class InstagramBaseService: NSObject {
    
    //MARK: Properties
    fileprivate(set) var networkClient: InstagramNetworkClient
    
    //MARK: Protected
    init(networkClient: InstagramNetworkClient) {
        self.networkClient = networkClient
    }
}
