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

public enum Instagram {}

private let instagramManagerKeychainStore = "com.InstagramClient.keychainStore"

final class InstagramClient {
  // MARK: - Properties
  fileprivate lazy var keychainStore: Keychain = {
    return Keychain(service: instagramManagerKeychainStore)
  }()
  fileprivate var networkManager: Alamofire.SessionManager = .default
  // MARK: - Public
  var authorizationURL: URL? {
    let parameters: [String : Any] = [Instagram.Keys.Auth.clientId: Instagram.Constants.appClientId,
                                      Instagram.Keys.Auth.redirectUri: Instagram.Constants.appRedirectURL,
                                      Instagram.Keys.Response.type: Instagram.Keys.Response.token,
                                      Instagram.Keys.Response.scope: Instagram.LoginScope.allScopesValue]
    return BaseNetworkClient.encode(Instagram.Constants.baseUrl + "oauth/authorize/", parameters: parameters)
  }
  //swiftlint:disable:next line_length
  func send<T : AnyInstagramResponse>(_ router: AnyInstagramNetworkRouter, completion: @escaping (T?, Error?) -> (Void)) {
    do {
      guard let accessToken = keychainStore[Instagram.Keys.Auth.accessToken] else {
        completion(nil, nil)
        return
      }
      let request = try router.asURLRequest(withAccessToken: accessToken)
      networkManager.request(request).validate().responseObject(completionHandler: { (response: DataResponse<T>) in
        // TODO: Need to setup check on access token expire
        completion(response.value, response.error)
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
