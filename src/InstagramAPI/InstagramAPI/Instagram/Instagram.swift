//
//  InstagramManager.swift
//  ConceptOffice
//
//  Created by Denis on 26.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import KeychainAccess


import ObjectMapper

private let InstagramManagerKeychainStore = Instagram.Constants.keychainStore

class InstagramManager: NSObject {
    static let shared = InstagramManager()
  
    fileprivate(set) lazy var networkClient: Instagram.NetworkClient = {
        return Instagram.NetworkClient(appClientId: self.appClientId, appRedirectURL: self.appRedirectURL, manager: self)
    }()
    
    fileprivate lazy var keychainStore: Keychain = {
        return Keychain(service: InstagramManagerKeychainStore)
    }()
    
    //TODO: Create constants
    fileprivate let appClientId: String = Instagram.Values.AuthValues.appClientId
    fileprivate var appRedirectURL: String = Instagram.Values.AuthValues.appRedirectURL

    fileprivate var isNeedToReceiveNewUser = false
    fileprivate(set) var lastReceivedUser: Instagram.User? {
        didSet {
            lastReceivedUserId = lastReceivedUser?.objectId
        }
    }
    fileprivate var lastReceivedUserId: String? {
        set {
            store(newValue, key: Keys.lastReceivedUserId)
        }
        get {
            return storedValue(Keys.lastReceivedUserId)
        }
    }
}

//MARK: Public
extension InstagramManager {
    
    var isLoggedIn: Bool {
       return lastReceivedUserId != nil
    }
    
    func authorizationURL() -> URL? {
        let parameters: [String : Any] = [Instagram.Keys.Auth.clientId: appClientId, Instagram.Keys.Auth.redirectUri: appRedirectURL, Instagram.Keys.Response.type: Instagram.Keys.Response.token, Instagram.Keys.Response.scope: InstagramLoginScope.allScopesValue]
      return networkClient.encode(Instagram.Keys.Network.authorizationPath, parameters: parameters)
    }
    
    func receiveLoggedInUser(_ url: URL?, completion: ((Instagram.User?, Error?)->())?) {
        if let accessToken = networkClient.getAccessToken(url) , accessToken.characters.count > 0 {
            isNeedToReceiveNewUser = true
            keychainStore[Instagram.Keys.Auth.accessToken] = accessToken
            
            let params = Instagram.UsersEndpoint.Parameter.User()
            let request = Instagram.UsersEndpoint.Get.user(params)
    
            networkClient.send(request, completion: { [weak self] (user: InstagramObjectResponse<Instagram.User>?, error: Error?) in
                if let user = user?.data, let objectId = user.objectId , objectId.characters.count > 0 {
                    let currentAccessToken = self?.keychainStore[Instagram.Keys.Auth.accessToken]
                    self?.keychainStore[Instagram.Keys.Auth.accessToken + objectId] = currentAccessToken
                    do {
                        try self?.keychainStore.remove(Instagram.Keys.Auth.accessToken)
                    }
                    catch {
                        let error = error as NSError
                        print("\(error.localizedDescription)")
                    }
                    self?.lastReceivedUser = user
                }
                else {
                    self?.lastReceivedUser = nil
                }
                self?.cleanUpCookies()
                self?.isNeedToReceiveNewUser = false
                completion?(self?.lastReceivedUser, error)
   
            })
        }
        else {
            completion?(nil, nil)
        }
    }
    
    func endLogin() {
        lastReceivedUser = nil
        cleanUpCookies()
    }
    
    func accessToken(_ instagramUserId: String?) -> String? {
        
        var result: String?
        if let instagramUserId = instagramUserId {
            result = keychainStore[Instagram.Keys.Auth.accessToken + instagramUserId]
        }
        return result
    }
    
    func logoutAccounts(withIDs accountIDs: [String], completion: ((Bool, Error?)->())?) {
        finishLogout(forCurrentUsers: accountIDs, completion: completion)
    }
    
    func refreshAccount(forInstagramId instagramId: String?) {
        guard let instagramId = instagramId else {
            print("no instagram id")
            return
        }
        
        let params = Instagram.UsersEndpoint.Parameter.User(instagramId)
        let request = Instagram.UsersEndpoint.Get.user(params)
        
        networkClient.send(request, completion: { [weak self] (user: InstagramObjectResponse<Instagram.User>?, error: Error?) in
            if let user = user?.data {
                self?.lastReceivedUser = user
            }
        })
    }
    
    func checkAccessTokenExpirationInResponse(with meta: InstagramMetaObject?) {
        if let meta = meta, meta.isAccessTokenException {
            //TODO: Need to think about it
        }
    }
    
    func cleanUpCookies() {
        keychainStore[Instagram.Keys.Auth.accessToken] = nil
        networkClient.cleanUpCookies()
    }
    
  }

private extension InstagramManager {
    func finishLogout(forCurrentUsers currentUserIDs: [String], completion: ((Bool, Error?)->())?) {
        for currentUserId in currentUserIDs {
            do {
                try keychainStore.remove(Instagram.Keys.Auth.accessToken + currentUserId)
            }
            catch {
                let error = error as NSError
                print("\(error.localizedDescription)")
            }
        }
        lastReceivedUser = nil
    }
}

extension InstagramManager: InstagramNetworkClientManagerProtocol {
    var instagramAccessToken: String? {
        var result: String?
        if let currentUserId = lastReceivedUserId , isNeedToReceiveNewUser == false {
            result = keychainStore[Instagram.Keys.Auth.accessToken + currentUserId]
        }
        else {
            result = keychainStore[Instagram.Keys.Auth.accessToken]
        }
        return result
    }
}

fileprivate extension InstagramManager {
    func store<ValueType>(_ value: ValueType?, key: String) {
        UserDefaults.standard.setValue(value, forKeyPath: key)
        UserDefaults.standard.synchronize()
    }
    
    func storedValue<ValueType>(_ key: String) -> ValueType? {
        return UserDefaults.standard.value(forKey: key) as? ValueType
    }
}


extension InstagramManager {
    enum Keys {
        static let lastReceivedUserId = "InstagramManagerLastReceivedUserId"
    }
}
