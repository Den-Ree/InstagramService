//
//  InstagramNetworkClient.swift
//  ConceptOffice
//
//  Created by Denis on 22.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import ObjectMapper


typealias HTTPMethod = String
typealias NetworkBodyObject = (key : String, value : String)

protocol InstagramNetworkClientManagerProtocol: NSObjectProtocol {
    var instagramAccessToken: String? {get}
}

protocol InstagramRequestProtocol {
    var path: String {get}
    var parameters: InstagramRequestParameters {get}
    var method: HTTPMethod {get}
    var bodyObject: NetworkBodyObject? {get}
}

extension InstagramRequestProtocol {
    var method: HTTPMethod {
        return Instagram.Keys.HTTPMethod.get
    }
    
    var bodyObject: NetworkBodyObject? {
        return nil
    }
}

extension Instagram{

  //MARK: - NetworkClient
  
  struct NetworkClient {
    
    fileprivate var appClientId: String
    fileprivate var appRedirectURL: String
    fileprivate weak var manager: InstagramNetworkClientManagerProtocol?
    fileprivate let session = URLSession.shared
    
    var accessToken: String? {
      return manager?.instagramAccessToken
    }
    
    init(appClientId: String, appRedirectURL: String, manager: InstagramNetworkClientManagerProtocol) {
      self.appClientId = appClientId
      self.appRedirectURL = appRedirectURL
      self.manager = manager
    }
    
    func sendRequest<T : InstagramResponse>(_ HTTPMethod : HTTPMethod, path: String?, parameters: [String : Any], bodyObject: NetworkBodyObject?, completion: @escaping (T?, Error?) -> ()){
      
      
      if (Network.reachability?.isReachable)! == false{
        return
      }
      
      
      var urlRequest = URLRequest(url: self.encode(path, parameters: parameters)!)
      urlRequest.httpMethod = HTTPMethod
      urlRequest.cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
      
      if let bodyObject = bodyObject{
        let bodyString =  bodyObject.key + "=" + bodyObject.value
        urlRequest.httpBody = bodyString.data(using: String.Encoding.utf8, allowLossyConversion: false)
      }
      
      let task = session.dataTask(with: urlRequest, completionHandler: {
          (data, responce, error) in
        
        if let error = error{
          completion(nil, error)
        } else {
          do{
            
          
            } catch {
            completion(nil,nil)
          }
        }
      })
      task.resume()
    }
    
    func encode(_ path : String?, parameters : [String:Any]) -> URL?{
      
      var components = URLComponents()
      
      components.scheme = Instagram.Keys.Network.scheme
      components.host = Instagram.Keys.Network.host
      components.path = path!
      components.queryItems = [URLQueryItem]()
      
      //Check if the components are from authorisationURL
      if components.path == Instagram.Keys.Network.authorizationPath{
        let sortedKeys = Array(parameters.keys).sorted(by: {$0 < $1})
        for key in sortedKeys{
          let queryItem = URLQueryItem(name: key, value: parameters[key] as? String)
          components.queryItems?.append(queryItem)
        }
      
      } else{
        for (key, value) in parameters{
          let queryItem = URLQueryItem(name: key, value: value as? String)
          components.queryItems?.append(queryItem)
        }
      }
      if let url = components.url{
        return url
      } else {
        return nil
      }
    }
    
    func send<T: InstagramResponse>(_ request: InstagramRequestProtocol, completion: @escaping (T?, Error?) -> ()){
        self.sendRequest(request.method, path: request.path, parameters: request.parameters, bodyObject: request.bodyObject, completion: completion)
    }
  }
}

extension Instagram.NetworkClient{
  
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
      result[Instagram.Keys.Auth.accessToken] = accessToken as AnyObject?
    }
    else {
      result[Instagram.Keys.Auth.clientId] = appClientId as AnyObject?
    }
    
    return result
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


extension Instagram{
  enum Path{
    //MARK: URLs
    func instagramUserMediaPath(_ userId: String?) -> InstagramURLPath {
      
      var result = String.emptyString
      if let userId = userId {
        result = "/users/\(userId)/media/recent"
      }
      else {
        result = "/users/self/media/recent"
      }
      return result
    }
    
    func instagramUserMediaLikedPath() -> InstagramURLPath {
      
      let result = "/users/self/media/liked"
      return result
    }
    
    func instagramUserInfoPath(_ userId: String?) -> InstagramURLPath {
      
      var result = String.emptyString
      if let userId = userId {
        result = "/users/\(userId)"
      }
      else {
        result = "/users/self"
      }
      return result
    }
    
    func instagramSearchUsersPath() -> InstagramURLPath {
      
      let result = "/users/search"
      return result
    }
    
    func instagramLikesPath(_ mediaId: String) -> InstagramURLPath {
      
      let result = "/media/\(mediaId)/likes"
      return result
    }
    
    func instagramCommentsPath(_ mediaId: String) -> InstagramURLPath {
      
      let result = "/media/\(mediaId)/comments"
      return result
    }
    
    func instagramFollowersPath() -> InstagramURLPath {
      
      let result = "/users/self/followed-by"
      return result
    }
    
    func instagramTagsPath(_ name: String) -> InstagramURLPath {
      
      let result = "/tags/\(name)"
      return result
    }
    
    func instagramSearchTagsPath() -> InstagramURLPath {
      
      let result = "/tags/search"
      return result
    }
    
    func instagramTagMediaPath(_ name: String) -> InstagramURLPath {
      
      let result = "/tags/\(name)/media/recent"
      return result
    }
  }
}










