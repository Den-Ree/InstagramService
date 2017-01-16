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

protocol InstagramEndpointProtocol {
    var path: String {get}
    var parameters: [String: AnyObject] {get}
}

protocol InstagramRequestProtocol: InstagramEndpointProtocol {
    var method: HTTPMethod {get}
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
    
    override func sendRequest<T : Mappable>(_ method: HTTPMethod = .get, path: String?, parameters: [String : AnyObject], bodyObject: NetworkBodyObject?, completion: @escaping (T?, Error?) -> ()) {
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
    func send<T: Mappable>(_ request: InstagramRequestProtocol, bodyObject: NetworkBodyObject?, completion: @escaping (T?, Error?) -> ()) {
    
        super.sendRequest(request.method, path: instagramBaseURLPath + request.path, parameters: addAccessToken(request.parameters), bodyObject: bodyObject, completion: completion)
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

extension UserId {
    var string: String {
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

extension UserRequest.Get: InstagramEndpointProtocol {
    
    var parameters: [String : AnyObject] {
        switch self {
        case .search(let name):
            return ["q": name as AnyObject]
        default:
            return [:]
        }
    }
    
    var path: String {
        var result = String()
        
        switch self {
        case .user(let userId):
            result = "/\(userId.string)"
        case .likedMedia:
            result = "/self/media/liked"
        case .recentMedia(let userId):
            result = "/\(userId.string)/media/recent"
        case .search(_):
            result = "/search"
        }
        
        return result
    }
}

extension UserRequest: InstagramRequestProtocol {
    var parameters: [String : AnyObject] {
        switch self {
        case .get(let endpoint):
            return endpoint.parameters
        }
    }

    var path: String {
        switch self {
        case .get(let endpoint):
            return "/users" + endpoint.path
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .get(_):
            return .get
        }
    }
}


