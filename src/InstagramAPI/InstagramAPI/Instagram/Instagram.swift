//
//  InstagramManager.swift
//  ConceptOffice
//
//  Created by Denis on 26.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import KeychainAccess

private let InstagramManagerKeychainStore = "com.InstagramManager.keychainStore"

class InstagramManager: NSObject {
    static let shared = InstagramManager()
    
    fileprivate(set) lazy var mediaService: InstagramMediaService = {
        return InstagramMediaService(networkClient: self.networkClient)
    }()
    
    lazy var userService: InstagramUserService = {
        return InstagramUserService(networkClient: self.networkClient)
    }()
 
    fileprivate(set) lazy var commentService: InstagramCommentService = {
        return InstagramCommentService(networkClient: self.networkClient)
    }()
    
    fileprivate(set) lazy var likeService: InstagramLikeService = {
        return InstagramLikeService(networkClient: self.networkClient)
    }()
    
    fileprivate(set) lazy var tagService: InstagramTagService = {
        return InstagramTagService(networkClient: self.networkClient)
    }()
    
    fileprivate lazy var networkClient: InstagramNetworkClient = {
        return InstagramNetworkClient(appClientId: self.appClientId, appRedirectURL: self.appRedirectURL, manager: self)
    }()
    
    fileprivate lazy var keychainStore: Keychain = {
        return Keychain(service: InstagramManagerKeychainStore)
    }()
    
    //TODO: Create constants
    fileprivate let appClientId: String = "eb6961971b7149899a3692a4125bb6af"
    fileprivate var appRedirectURL: String = "https://www.nolisto.com"

    fileprivate var isNeedToReceiveNewUser = false
    fileprivate(set) var lastReceivedUser: InstagramUser?
}

//MARK: Public
extension InstagramManager {
    
    func authorizationURL() -> URL? {
        let parameters: [String : Any] = [kInstagramCliendId: appClientId, kInstagramRedirectUri: appRedirectURL, kInstagramResponseType: kInstagramToken, kInstagramScope: InstagramLoginScope.allScopesValue]
        return networkClient.encode(instagramAuthorizationURLPath, parameters: parameters)
    }
    
    func receiveLoggedInUser(_ url: URL?, completion: ((InstagramUser?, Error?)->())?) {
        if let accessToken = networkClient.getAccessToken(url) , accessToken.characters.count > 0 {
            isNeedToReceiveNewUser = true
            keychainStore[kInstagramAccessToken] = accessToken
            
            userService.fetchUser(userId: nil) { [weak self] (user: InstagramUser?, error: Error?) -> () in
                if let user = user, let objectId = user.objectId , objectId.characters.count > 0 {
                    let currentAccessToken = self?.keychainStore[kInstagramAccessToken]
                    self?.keychainStore[kInstagramAccessToken + objectId] = currentAccessToken
                    do {
                        try self?.keychainStore.remove(kInstagramAccessToken)
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
            }
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
            result = keychainStore[kInstagramAccessToken + instagramUserId]
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
        
        userService.fetchUser(userId: instagramId) { (user, error) in
            if let user = user {
                self.lastReceivedUser = user
            }
        }
    }
    
    func checkAccessTokenExpirationInResponse(with meta: InstagramMetaObject?) {
        if let meta = meta, meta.isAccessTokenException {
            //TODO: Need to think about it
        }
    }
    
    func cleanUpCookies() {
        keychainStore[kInstagramAccessToken] = nil
        networkClient.cleanUpCookies()
    }
    
    func cleanUpCachedMedia() {
        let clients = [mediaService as InstagramCacheClient, commentService as InstagramCacheClient]
        InstagramCacheManager.shared.removeCachedObject(clients)
    }
}

private extension InstagramManager {
    func finishLogout(forCurrentUsers currentUserIDs: [String], completion: ((Bool, Error?)->())?) {
        for currentUserId in currentUserIDs {
            do {
                try keychainStore.remove(kInstagramAccessToken + currentUserId)
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
        if let currentUserId = lastReceivedUser?.objectId , isNeedToReceiveNewUser == false {
            result = keychainStore[kInstagramAccessToken + currentUserId]
        }
        else {
            result = keychainStore[kInstagramAccessToken]
        }
        return result
    }
}

extension InstagramManager {
    struct Notifications {
        static let noLoggedInAccounts = "InstagramManagerNoLoggedInAccountsNotification"
        static let mediaWasChanged = "InstagramManagerMediaDidChangedNotification"
        static let accessTokenExpired = "InstagramManagerMediaAccessTokenExpired"
    }
}
