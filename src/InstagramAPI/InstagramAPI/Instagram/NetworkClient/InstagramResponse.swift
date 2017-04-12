//
//  InstagramResponse.swift
//  ConceptOffice
//
//  Created by Denis on 23.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import ObjectMapper

protocol InstagramResponse: Mappable {}

class InstagramObjectResponse <T: Mappable> : NSObject, InstagramResponse {
    var data: T?
    var meta: InstagramMetaObject?
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        data <- map[Instagram.Keys.Response.data]
        meta <- map[Instagram.Keys.Response.meta]
    }
}

class InstagramArrayResponse <T: Mappable> : NSObject, InstagramResponse {
    var data: [T]?
    var meta: InstagramMetaObject?
    var pagination: InstagramPaginationInfo?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        data <- map[Instagram.Keys.Response.data]
        meta <- map[Instagram.Keys.Response.meta]
        pagination <- map[Instagram.Keys.Response.pagination]
    }
}

class InstagramMetaResponse: NSObject, Mappable, InstagramResponse {
    var meta: InstagramMetaObject?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        meta <- map[Instagram.Keys.Response.meta]
    }
}

class InstagramPaginationInfo: NSObject, Mappable, InstagramResponse {
    
    var nextURL: URL?
    var nextMaxId: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        nextURL <- (map[Instagram.Keys.Pagination.nextURL], URLTransform())
        nextMaxId <- map[Instagram.Keys.Pagination.nextMaxId]
    }
}

class InstagramMetaObject: NSObject, Mappable {
    var code: Int?
    var errorType: String?
    var errorMessage: String?
    
    var isSuccessCode: Bool {
        var result = false
        if let code = code , code == 200 {
            result = true
        }
        return result
    }
    
    var isAccessTokenException: Bool {
        var result = false
        if let errorType = errorType {
            result = errorType == "OAuthAccessTokenException"
        }
        return result
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        code <- map[Instagram.Keys.Error.code]
        errorType <- map[Instagram.Keys.Error.type]
        errorMessage <- map[Instagram.Keys.Error.message]
    }
}

