//
//  Instagram.swift
//  ConceptOffice
//
//  Created by Denis on 26.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import SafariServices
import KeychainAccess
import Alamofire
import AlamofireObjectMapper

public enum Instagram {}

private let instagramManagerKeychainStore = "com.InstagramClient.keychainStore"

public enum InstagramAuthUrlFragment{
  case empty
  case code(String)
  case accessToken(String)
}

final class InstagramClient {
  // MARK: - Properties
  fileprivate lazy var keychainStore: Keychain = {
    return Keychain(service: instagramManagerKeychainStore)
  }()
  fileprivate var networkManager: Alamofire.SessionManager = .default
  // MARK: - Public
  
  struct authorisationUrl{
    
    var clientSideFlowUrl: URL? {
    let parameters: [String : Any] = [Instagram.Keys.Auth.clientId: Instagram.Constants.appClientId,
                                      Instagram.Keys.Auth.redirectUri: Instagram.Constants.appRedirectURL,
                                      Instagram.Keys.Response.type: Instagram.Keys.Response.token,
                                      Instagram.Keys.Response.scope: Instagram.LoginScope.allScopesValue]
    return InstagramClient().encode(Instagram.Constants.baseUrl + "oauth/authorize/", parameters: parameters)
    }

    var sereverSideFlowUrl: URL? {
    let parameters: [String : Any] = [Instagram.Keys.Auth.clientId: Instagram.Constants.appClientId,
                                      Instagram.Keys.Auth.redirectUri: Instagram.Constants.appRedirectURL,
                                      Instagram.Keys.Response.type: Instagram.Keys.Response.code,
                                      Instagram.Keys.Response.scope: Instagram.LoginScope.allScopesValue]
    return InstagramClient().encode(Instagram.Constants.baseUrl + "oauth/authorize/", parameters: parameters)
    }
  }
  
    func send<T : AnyInstagramResponse>(_ router: AnyInstagramNetworkRouter, completion: @escaping (T?, Error?) -> (Void)) {
    do {
      guard let accessToken = keychainStore[Instagram.Keys.Auth.accessToken] else {
        completion(nil, nil)
        return
      }
      let request = try router.asURLRequest(withAccessToken: accessToken)
    

      networkManager.request(request).validate().responseObject(completionHandler: { (response: DataResponse<T>) in
        // TODO: Need to setup check on access token expire
        completion(response.data, response.e)
      })
    } catch {
      completion(nil, error)
    }
  }
}
extension InstagramClient {
  struct Notifications {
    static let noLoggedInAccounts = "InstagramClientNoLoggedInAccountsNotification"
    static let mediaWasChanged = "InstagramClientMediaDidChangedNotification"
    static let accessTokenExpired = "InstagramClientMediaAccessTokenExpired"
  }
}

//  MARL: Authorization
extension InstagramClient{

  func getAuthUrlFragment(_ Url: URL) -> InstagramAuthUrlFragment{
    let appRedirectUrl: URL = URL(string: Instagram.Constants.appRedirectURL)!
    // Check if our Url isRedirect
    if appRedirectUrl.scheme == Url.scheme && appRedirectUrl.host == Url.host{
      
      // Then check both flows
      var components = Url.absoluteString.components(separatedBy: Instagram.Keys.Auth.accessToken + "=")
      
      if components.count == 2{
        return .accessToken(components.last!)
      }
      
      components = Url.absoluteString.components(separatedBy: Instagram.Keys.Auth.code + "=")

      if components.count == 2{
        return .code(components.last!)
      }
    return .empty
    }
  }
  
  func receiveLoggedUser(_ Url: URL, completion: ((InstagramUser?,Error) -> ())?){
    
  }
  
  func encode(_ path: String?, parameters: [String: Any]) -> URL? {
      
    guard let path = path, let encodedPath = path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed), let url = URL(string: encodedPath) else {
      return nil
    }
      
    do {
      let initialRequest = URLRequest(url: url)
      let request = try URLEncoding(destination: .methodDependent).encode(initialRequest, with: parameters)
      return request.url
    } catch {
      print("\((error as NSError).localizedDescription)")
      return nil
    }
  }

  
}



