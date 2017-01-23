//
//  InstagramNetworkClient.swift
//  ConceptOffice
//
//  Created by Denis on 22.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

protocol InstagramNetworkClientManagerProtocol: NSObjectProtocol {
    var instagramAccessToken: String? {get}
}

protocol InstagramRequestProtocol {
    var path: String {get}
    var parameters: [String: AnyObject] {get}
    var method: HTTPMethod {get}
    var bodyObject: NetworkBodyObject? {get}
}

extension InstagramRequestProtocol {
    var method: HTTPMethod {
        return .get
    }
    
    var bodyObject: NetworkBodyObject? {
        return nil
    }
}

class InstagramNetworkClient: BaseNetworkClient {
    
    //MARK: Properties
    fileprivate var appClientId: String
    fileprivate var appRedirectURL: String
    fileprivate weak var manager: InstagramNetworkClientManagerProtocol?
    
    var accessToken: String? {
        return manager?.instagramAccessToken
    }
    
    //MARK: Protected
    init(appClientId: String, appRedirectURL: String, manager: InstagramNetworkClientManagerProtocol) {
        self.appClientId = appClientId
        self.appRedirectURL = appRedirectURL
        self.manager = manager
    }
    
    override func sendRequest<T : InstagramResponse>(_ method: HTTPMethod = .get, path: String?, parameters: [String : AnyObject], bodyObject: NetworkBodyObject?, completion: @escaping (T?, Error?) -> ()) {
        super.sendRequest(method, path: path, parameters: addAccessToken(parameters), bodyObject: bodyObject, completion: completion)
    }
    
    func getAccessToken(_ url: URL?) -> String? {
        
        guard let url = url else {
            return nil
        }
        
        let isRedirect = isRedirectURL(url)
        
        if !isRedirect {
            return nil
        }
        
        let components = url.absoluteString.components(separatedBy: "access_token=")
        if components.count == 2 {
            if let count = components.last?.characters.count, count > 0 {
                return components.last
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    func cleanUpCookies() {
        let storage = HTTPCookieStorage.shared
        if let cookies = storage.cookies {
            for (_, cookie) in cookies.enumerated() {
                storage.deleteCookie(cookie)
            }
        }
    }
    
    //MARK: Private
    fileprivate func addAccessToken(_ parameters: InstagramRequestParameters) -> InstagramRequestParameters {
        
        var result = parameters
        if let accessToken = accessToken {
            result[kInstagramAccessToken] = accessToken as AnyObject?
        }
        else {
            result[kInstagramCliendId] = appClientId as AnyObject?
        }
        
        return result
    }
}

extension InstagramNetworkClient {
    func send<T: InstagramResponse>(_ request: InstagramRequestProtocol, completion: @escaping (T?, Error?) -> ()) {
        super.sendRequest(request.method, path: instagramBaseURLPath + request.path, parameters: addAccessToken(request.parameters), bodyObject: request.bodyObject, completion: completion)
    }
}

extension InstagramNetworkClient {

    //MARK: URLs
    func instagramUserMediaPath(_ userId: String?) -> InstagramURLPath {

        var result = String.emptyString
        if let userId = userId {
            result = "/users/\(userId)/media/recent"
        }
        else {
            result = "/users/self/media/recent"
        }
        return instagramBaseURLPath + result
    }
    
    func instagramUserMediaLikedPath() -> InstagramURLPath {
        
        let result = "/users/self/media/liked"
        return instagramBaseURLPath + result
    }
    
    func instagramUserInfoPath(_ userId: String?) -> InstagramURLPath {
        
        var result = String.emptyString
        if let userId = userId {
            result = "/users/\(userId)"
        }
        else {
            result = "/users/self"
        }
        return instagramBaseURLPath + result
    }
    
    func instagramSearchUsersPath() -> InstagramURLPath {
        
        let result = "/users/search"
        return instagramBaseURLPath + result
    }
    
    func instagramLikesPath(_ mediaId: String) -> InstagramURLPath {
        
        let result = "/media/\(mediaId)/likes"
        return instagramBaseURLPath + result
    }

    func instagramCommentsPath(_ mediaId: String) -> InstagramURLPath {
        
        let result = "/media/\(mediaId)/comments"
        return instagramBaseURLPath + result
    }
    
    func instagramFollowersPath() -> InstagramURLPath {
        
        let result = "/users/self/followed-by"
        return instagramBaseURLPath + result
    }
    
    func instagramTagsPath(_ name: String) -> InstagramURLPath {
        
        let result = "/tags/\(name)"
        return instagramBaseURLPath + result
    }
    
    func instagramSearchTagsPath() -> InstagramURLPath {
        
        let result = "/tags/search"
        return instagramBaseURLPath + result
    }
    
    func instagramTagMediaPath(_ name: String) -> InstagramURLPath {
        
        let result = "/tags/\(name)/media/recent"
        return instagramBaseURLPath + result
    }

    
    func isRedirectURL(_ url: URL) -> Bool {
        //check if we has correct app redirect url
        guard let appRedirectURL = URL(string: appRedirectURL) else {
            return false
        }
        
        //check if both urls have host
        guard let host = appRedirectURL.host, let urlHost = url.host else {
            return false
        }
        
        return appRedirectURL.scheme == url.scheme && host == urlHost
    }
}

//MARK: Users endpoints extensions

extension Instagram.UsersEndpoint.User {
    var pathComponent: String {
        var result = String()
        
        switch self {
        case .id(let userId):
            result = "\(userId)"
        case .owner:
            result = "self"
        }
        
        return result
    }
}

extension Instagram.UsersEndpoint.Get {
    
    var path: String {
        switch self {
        case .user(let user):
            return "/users/\(user.pathComponent)"
        case .likedMedia(_):
            return "/users/self/media/liked"
        case .recentMedia(let parameters):
            return "/users/\(parameters.user.pathComponent)/media/recent"
        case .search(_):
            return "/users/search"
        }
    }
    
    var parameters: [String: AnyObject] {
       
        switch self {
        case .user(let user):
            return [:]
        case .likedMedia(let parameters):
            return [:]
        case .recentMedia(let parameters):
            return [:]
        case .search(let parameters):
            return [
                "q"     : parameters.query as AnyObject,
                "count" : parameters.count as AnyObject
            ]
        }
    }
}

//MARK: Relationships endpoints

extension Instagram.RelationshipEnpoint.Get {
    var path: String {
        //TODO: Need to fill
        return ""
    }
    
    var parameters: [String: AnyObject] {
        //TODO: Need to fill
        return [:]
    }
}

extension Instagram.RelationshipEnpoint.Post {
    var path: String {
        //TODO: Need to fill
        return ""
    }
    
    var parameters: [String: AnyObject] {
        //TODO: Need to fill
        return [:]
    }
    
    var method: HTTPMethod {
        return .post
    }
}

//MARK: Media endpoints
extension Instagram.MediaEndpoint.Get {
    var path: String {
        //TODO: Need to fill
        return ""
    }
    
    var parameters: [String: AnyObject] {
        //TODO: Need to fill
        return [:]
    }
}

//MARK: Comments endpoints
extension Instagram.CommentsEndpoint.Get {
    var path: String {
        //TODO: Need to fill
        return ""
    }
    
    var parameters: [String: AnyObject] {
        //TODO: Need to fill
        return [:]
    }
}

extension Instagram.CommentsEndpoint.Post {
    var path: String {
        //TODO: Need to fill
        return ""
    }
    
    var parameters: [String: AnyObject] {
        //TODO: Need to fill
        return [:]
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var bodyObject: NetworkBodyObject? {
        //TODO: Need to fill
        return nil
    }
}

extension Instagram.CommentsEndpoint.Delete {
    var path: String {
        //TODO: Need to fill
        return ""
    }
    
    var parameters: [String: AnyObject] {
        //TODO: Need to fill
        return [:]
    }
    
    var method: HTTPMethod {
        return .delete
    }
}


//MARK: Likes endpoints
extension Instagram.LikesEndpoint.Get {
    var path: String {
        //TODO: Need to fill
        return ""
    }
    
    var parameters: [String: AnyObject] {
        //TODO: Need to fill
        return [:]
    }
}

extension Instagram.LikesEndpoint.Post {
    var path: String {
        //TODO: Need to fill
        return ""
    }
    
    var parameters: [String: AnyObject] {
        //TODO: Need to fill
        return [:]
    }
    
    var method: HTTPMethod {
        return .post
    }
}

extension Instagram.LikesEndpoint.Delete {
    var path: String {
        //TODO: Need to fill
        return ""
    }
    
    var parameters: [String: AnyObject] {
        //TODO: Need to fill
        return [:]
    }
    
    var method: HTTPMethod {
        return .delete
    }
}


//MARK: Tags endpoints
extension Instagram.TagsEndpoint.Get {
    var path: String {
        //TODO: Need to fill
        return ""
    }
    
    var parameters: [String: AnyObject] {
        //TODO: Need to fill
        return [:]
    }
}


//MARK: Location endpoints
extension Instagram.LocationsEndpoint.Get {
    var path: String {
        //TODO: Need to fill
        return ""
    }
    
    var parameters: [String: AnyObject] {
        //TODO: Need to fill
        return [:]
    }
}
