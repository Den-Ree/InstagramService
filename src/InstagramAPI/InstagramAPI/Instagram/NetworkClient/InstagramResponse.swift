//
//  InstagramResponse.swift
//  ConceptOffice
//
//  Created by Denis on 23.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit

import AlamofireObjectMapper
import ObjectMapper

protocol InstagramResponse: Mappable {}

class InstagramObjectResponse <T: Mappable> : NSObject, InstagramResponse {
    var data: T?
    var meta: InstagramMetaObject?
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        data <- map[kInstagramData]
        meta <- map[kInstagramMeta]
    }
}

class InstagramArrayResponse <T: Mappable> : NSObject, InstagramResponse {
    var data: [T]?
    var meta: InstagramMetaObject?
    var pagination: InstagramPaginationInfo?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        data <- map[kInstagramData]
        meta <- map[kInstagramMeta]
        pagination <- map[kInstagramPagination]
    }
}

class InstagramMetaResponse: NSObject, Mappable, InstagramResponse {
    var meta: InstagramMetaObject?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        meta <- map[kInstagramMeta]
    }
}

class InstagramPaginationInfo: NSObject, Mappable, InstagramResponse {
    
    var nextURL: URL?
    var nextMaxId: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        nextURL <- (map[kInstagramNextURL], URLTransform())
        nextMaxId <- map[kInstagramNextMaxId]
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
        code <- map[kInstagramCode]
        errorType <- map[kInstagramErrorType]
        errorMessage <- map[kInstagramErrorMessage]
    }
}

