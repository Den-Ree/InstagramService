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

private let instagramManagerKeychainStore = "com.InstagramClient.keychainStore"

public final class InstagramClient {
  // MARK: - Properties
  fileprivate lazy var keychainStore: Keychain = {
    return Keychain(service: instagramManagerKeychainStore)
  }()
  fileprivate var networkManager: Alamofire.SessionManager = .default
  // MARK: - Public
  public var isLogged: Bool {
    return self.keychainStore["isLogged"] == "true"
  }
  public var loggedUserId: String {
    get {
      return self.keychainStore["lastUserId"]!
    }
    set (newValue) {
      self.keychainStore["lastUserId"] = newValue
    }
  }

  public enum InstagramAuthUrlFragment {
    case empty
    case code(String)
    case accessToken(String)
  }

  public struct InstagramAuthorisationUrl {
    public var clientSideFlowUrl: URL? {
    let parameters: [String : Any] = [Instagram.Keys.Auth.clientId: Instagram.Constants.appClientId,
                                      Instagram.Keys.Auth.redirectUri: Instagram.Constants.appRedirectURL,
                                      Instagram.Keys.Response.type: Instagram.Keys.Response.token,
                                      Instagram.Keys.Response.scope: Instagram.LoginScope.allScopesValue]
    return InstagramClient().encode(Instagram.Constants.baseUrl + "oauth/authorize/", parameters: parameters)
    }

    public var serverSideFlowUrl: URL? {
    let parameters: [String : Any] = [Instagram.Keys.Auth.clientId: Instagram.Constants.appClientId,
                                      Instagram.Keys.Auth.redirectUri: Instagram.Constants.appRedirectURL,
                                      Instagram.Keys.Response.type: Instagram.Keys.Response.code,
                                      Instagram.Keys.Response.scope: Instagram.LoginScope.allScopesValue]
    return InstagramClient().encode(Instagram.Constants.baseUrl + "oauth/authorize/", parameters: parameters)
    }
  }

  public func send<T: AnyInstagramResponse>(_ router: AnyInstagramNetworkRouter, completion: @escaping (T?, Error?) -> Void) {
      do {
        guard let accessToken = keychainStore[Instagram.Keys.Auth.accessToken + loggedUserId] else {
            completion(nil, nil)
          return
        }
        let request = try router.asURLRequest(withAccessToken: accessToken)
        request.description(router: router)
        networkManager.request(request).validate().responseObject(completionHandler: { (response: DataResponse<T>) in
          self.checkAccessTokenExpiration(response)
          response.description()
          completion(response.result.value, response.result.error)
        })
      } catch {
        completion(nil, error)
      }
  }
}

public extension InstagramClient {
  public struct Notifications {
    static let noLoggedInAccounts = "InstagramClientNoLoggedInAccountsNotification"
    static let mediaWasChanged = "InstagramClientMediaDidChangedNotification"
    static let accessTokenExpired = "InstagramClientMediaAccessTokenExpired"
  }
}

//  MARL: Authorization
public extension InstagramClient {

  fileprivate func getAuthUrlFragment(_ Url: URL) -> InstagramAuthUrlFragment {
    let appRedirectUrl: URL = URL(string: Instagram.Constants.appRedirectURL)!
    // Check if our Url isRedirect
    if appRedirectUrl.scheme == Url.scheme && appRedirectUrl.host == Url.host {
      // Then check both flows
      var components = Url.absoluteString.components(separatedBy: Instagram.Keys.Auth.accessToken + "=")
      if components.count == 2 {
        return .accessToken(components.last!)
      }
      components = Url.absoluteString.components(separatedBy: Instagram.Keys.Auth.code + "=")
      if components.count == 2 {
        return .code(components.last!)
      }
    }
    return .empty
  }

  public func receiveLoggedUser(_ Url: URL, completion: ((String?, Error?) -> Void)?) {
    switch InstagramClient().getAuthUrlFragment(Url) {

    case .empty: return
    case .accessToken(let accessToken):
        self.keychainStore[Instagram.Keys.Auth.accessToken] = accessToken
        let router = InstagramUserRouter.getUser(.owner)
        self.send(router, completion: { [weak self] (response: InstagramModelResponse<InstagramUser>?, error: Error?) in
          if error == nil && response?.data != nil && response?.data.id != nil {
            let currentAccessToken = self?.keychainStore[Instagram.Keys.Auth.accessToken]
            self?.keychainStore[Instagram.Keys.Auth.accessToken + (response?.data.id)!] = currentAccessToken
            do {
              try self?.keychainStore.remove(Instagram.Keys.Auth.accessToken)
            } catch {
              print(error.localizedDescription)
            }

            self?.cleanCookies()
            self?.keychainStore["isLogged"] = "true"
            self?.loggedUserId = (response?.data.id)!
            completion?(self?.loggedUserId, nil)
          } else {
            completion?(nil, nil)
          }
        })

        break
    case .code(let code):
      let parameters = [Instagram.Keys.Auth.clientId: Instagram.Constants.appClientId,
                        Instagram.Keys.Auth.clientSecret: Instagram.Constants.appClientSecret,
                        Instagram.Keys.Auth.grantType: Instagram.Constants.grantType,
                        Instagram.Keys.Auth.redirectUri: Instagram.Constants.appRedirectURL,
                        Instagram.Keys.Auth.code: code]
      let url = URL(string: Instagram.Constants.baseUrl + "oauth/access_token/")
      var request = URLRequest.init(url: url!)
      request.httpMethod = HTTPMethod.post.rawValue
      let stringParams = parameters.parametersString()
      let dataParams = stringParams.data(using: String.Encoding.utf8, allowLossyConversion: true)
      let paramsLength = String(format: "%d", dataParams!.count)
      request.setValue(paramsLength, forHTTPHeaderField: "Content-Length")
      request.httpBody = dataParams
      request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

      networkManager.request(request).response(completionHandler: {(response: DefaultDataResponse?) in
          if let response = response {
            do {
              let json = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! Dictionary<String, Any>
              if let accessToken = json[Instagram.Keys.Auth.accessToken] as? String {
                let accessTokenUrl = Instagram.Constants.appRedirectURL + "/" + Instagram.Keys.Auth.accessToken + "=" + accessToken
                self.receiveLoggedUser(URL(string: accessTokenUrl)!, completion: nil)
              }
              completion?(self.loggedUserId, nil)
            } catch {
              completion?(nil, nil)
            }
          }
        })
      break
    }
  }

  public func checkAccessTokenExpiration<T: AnyInstagramResponse>(_ response: DataResponse<T>) {
      if response.result.value?.meta.errorType.rawValue == "OAuthAccessTokenError"{
          print(Notifications.accessTokenExpired)
          self.keychainStore[Instagram.Keys.Auth.accessToken + loggedUserId] = nil
          self.endLogin()
      }
  }

  public func endLogin() {
    self.loggedUserId = ""
    self.keychainStore["isLogged"] = "false"
    self.cleanCookies()
  }
  
  public func setClientParameters(_ accessToken: String, clientId: String){
    
    self.keychainStore[Instagram.Keys.Auth.accessToken + clientId] = accessToken
    self.loggedUserId = clientId
  }

}

public extension InstagramClient {

  public func encode(_ path: String?, parameters: [String: Any]) -> URL? {
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

  public func cleanCookies() {
    keychainStore[Instagram.Keys.Auth.accessToken] = nil
    let storage = HTTPCookieStorage.shared
    if let cookies = storage.cookies {
      for (_, cookie) in cookies.enumerated() {
        storage.deleteCookie(cookie)
      }
    }
  }

}

public extension URLRequest {
 // MARK: Request description
  public func description(router: AnyInstagramNetworkRouter) {
    router.describe()
    if self.url != nil {
      print("URL: \(String(describing: self.url!.absoluteString))")
    } else {
      print("URL: nil")
    }
    if self.httpBody != nil {
      guard let json = try? JSONSerialization.jsonObject(with: self.httpBody!, options: .allowFragments) as! [String:Any] else {
        return
      }
      print("HTTP Body: \(json)")
    } else {
      print("HTTP Body: nil")
    }
  }
}

public extension DataResponse {

  public func description() {
    print("\n")
    print("Instagram Network Responce Description...")
    if self.result.error == nil {
      print("Error: nil")
    } else {
      print("Error: \(String(describing: self.result.error?.localizedDescription))")
    }
    if self.result.isSuccess {
      print("Is success: true")
    } else {
      print("Is success: false")
    }
    if self.result.value == nil {
      print("Result: nil")
    } else {
      print("Result: \(String(describing: self.result.value))")
    }
    print("\n")
  }
}

public extension Dictionary {

  public func parametersString() -> String {
    var paramsString = [String]()
    for (key, value) in self {
      guard let stringValue = value as? String, let stringKey = key as? String else {
        return ""
      }
      paramsString += [stringKey + "=" + "\(stringValue)"]
    }
    return (paramsString.isEmpty ? "" : paramsString.joined(separator: "&"))
  }
}
