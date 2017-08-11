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

final class InstagramClient {
  // MARK: - Properties
  fileprivate lazy var keychainStore: Keychain = {
    return Keychain(service: instagramManagerKeychainStore)
  }()
  fileprivate var networkManager: Alamofire.SessionManager = .default
  // MARK: - Public
  var isLogged : Bool{
    return self.keychainStore["isLogged"] == "true"
  }
  var lastUser: InstagramUser? = InstagramUser()
  public enum InstagramAuthUrlFragment{
    case empty
    case code(String)
    case accessToken(String)
  }
  
  struct InstagramAuthorisationUrl{
    var clientSideFlowUrl: URL? {
    let parameters: [String : Any] = [Instagram.Keys.Auth.clientId: Instagram.Constants.appClientId,
                                      Instagram.Keys.Auth.redirectUri: Instagram.Constants.appRedirectURL,
                                      Instagram.Keys.Response.type: Instagram.Keys.Response.token,
                                      Instagram.Keys.Response.scope: Instagram.LoginScope.allScopesValue]
    return InstagramClient().encode(Instagram.Constants.baseUrl + "oauth/authorize/", parameters: parameters)
    }
      
    var serverSideFlowUrl: URL? {
    let parameters: [String : Any] = [Instagram.Keys.Auth.clientId: Instagram.Constants.appClientId,
                                      Instagram.Keys.Auth.redirectUri: Instagram.Constants.appRedirectURL,
                                      Instagram.Keys.Response.type: Instagram.Keys.Response.code,
                                      Instagram.Keys.Response.scope: Instagram.LoginScope.allScopesValue]
    return InstagramClient().encode(Instagram.Constants.baseUrl + "oauth/authorize/", parameters: parameters)
    }
  }
  
  func send<T : AnyInstagramResponse>(_ router: AnyInstagramNetworkRouter, completion: @escaping (T?, Error?) -> (Void)) {
      do {
        // Look on lastUser.id
        guard let accessToken = keychainStore[Instagram.Keys.Auth.accessToken + (lastUser?.id)!] else {
          completion(nil, nil)
          return
        }
        let request = try router.asURLRequest(withAccessToken: accessToken)
        print(request.url?.absoluteString)
        networkManager.request(request).validate().responseObject(completionHandler: { (response: DataResponse<T>) in
          // TODO: Need to setup check on access token expire
          print(response.result.value)
          completion(response.result.value, response.result.error)
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
    }
    return .empty
  }
  
  func receiveLoggedUser(_ Url: URL, completion: ((InstagramUser?,Error) -> ())?){
    switch InstagramClient().getAuthUrlFragment(Url) {
      
    case .empty: return
    case .accessToken(let accessToken):
      self.keychainStore[Instagram.Keys.Auth.accessToken] = accessToken
        let router = InstagramUserRouter.getUser(.owner)
        self.send(router, completion: { (responce: InstagramModelResponse<InstagramUser>?, error: Error?) in
          if error == nil && responce?.data != nil && responce?.data.id != nil{
            let currentAccessToken = self.keychainStore[Instagram.Keys.Auth.accessToken]
            self.keychainStore[Instagram.Keys.Auth.accessToken + (responce?.data.id)!] = currentAccessToken
            do{
              try self.keychainStore.remove(Instagram.Keys.Auth.accessToken)
            } catch {
              print(error.localizedDescription)
            }
            self.lastUser = responce?.data
            self.cleanCookies()
            self.keychainStore["isLogged"] = "true"
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
      let stringParams = parameters.paramsString()
      let dataParams = stringParams.data(using: String.Encoding.utf8, allowLossyConversion: true)
      let paramsLength = String(format: "%d", dataParams!.count)
      request.setValue(paramsLength, forHTTPHeaderField: "Content-Length")
      request.httpBody = dataParams
      request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
      
      networkManager.request(request).response(completionHandler: {(responce: DefaultDataResponse?) in
          if let responce = responce{
            do{
              let json = try JSONSerialization.jsonObject(with: responce.data!, options: .mutableContainers) as! Dictionary<String,Any>
              if let accessToken = json[Instagram.Keys.Auth.accessToken] as? String{
                let accessTokenUrl = Instagram.Constants.appRedirectURL + "/" + Instagram.Keys.Auth.accessToken + "=" + accessToken
                self.receiveLoggedUser(URL(string: accessTokenUrl)!, completion: nil)
              }
            }catch{
            }
          }
        })
      break
    }
  }
  
  func endLogin(){
    self.lastUser = nil
    self.keychainStore["isLogged"] = "false"
    self.cleanCookies()
  }
  
}

extension InstagramClient{
  
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
  
  func cleanCookies(){
    keychainStore[Instagram.Keys.Auth.accessToken] = nil
    let storage = HTTPCookieStorage.shared
    if let cookies = storage.cookies {
      for (_, cookie) in cookies.enumerated() {
        storage.deleteCookie(cookie)
      }
    }
  }
  
}


extension Dictionary {
  
  func paramsString() -> String {
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



