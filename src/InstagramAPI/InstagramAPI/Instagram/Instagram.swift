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
    
    fileprivate(set) lazy var userService: InstagramUserService = {
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
    fileprivate let appClientId: String = "be322b2540c745438432c86c825ed469"
    fileprivate var appRedirectURL: String {
        return SettingsManager.shared.config.instagramRedirectURL
    }

    fileprivate var isNeedToReceiveNewUser = false
    fileprivate(set) var lastReceivedUser: InstagramUser?
    
    //MARK: Protected
    override init() {
        super.init()
        subscribe(on: [AppCoreDataManager.Notifications.didChangeInstagramAccount], selector: #selector(InstagramManager.handle(_:)))
    }
    
    deinit {
        unsubscribeFromNotifications()
    }
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
                        AnalyticsManager.logReport(withFormat: "error_when_remove_keyichain_\(error.localizedDescription)")
                    }
                    self?.lastReceivedUser = user
                    AnalyticsManager.logReport(withFormat: "user_received_from_instagram")
                }
                else {
                    self?.lastReceivedUser = nil
                    AnalyticsManager.logReport(withFormat: "user_didn't_receive_from_instagram")
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
        AppBackend.manager.removeAccounts(accountIDs, completion: { (success, error) in
            if success {
                self.finishLogout(forCurrentUsers: accountIDs, completion: completion)
            }
            else {
                completion?(success, error)
            }
        })
    }
    
    func refreshAccount(forInstagramId instagramId: String?) {
        if let instagramId = instagramId {
            AnalyticsManager.logReport(withFormat: "refreshInstagramAccount - \(instagramId)")
        }
        userService.fetchUser(userId: instagramId) { (user, error) in
            if let user = user {
                if let selectedAccount = InstagramAccount.selectedInstagramAccount, let userMediaCount = user.counts?.media , selectedAccount.mediaCount != Int64(userMediaCount) {
                    AppNotifications.center.post(name: Notifications.mediaWasChanged)
                }
                AppCoreData.manager.updateInstagramAccount(user, completion: nil)
            }
        }
    }
    
    func checkAccessTokenExpirationInResponse(with meta: InstagramMetaObject?) {
        if let meta = meta, meta.isAccessTokenException {
            AppNotifications.center.post(name: Notifications.accessTokenExpired)
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
                AnalyticsManager.logReport(withFormat: "error_when_remove_keyichain_\(error.localizedDescription)")
            }
        }
        
        AppCoreData.manager.save({ (savingContext) in
            let predicate = NSPredicate.whereKey(InstagramAccount.Attributes.instagramId, containedIn: currentUserIDs)
            
            if let accountsInContext = InstagramAccount.findAll(predicate, context: savingContext) as? [InstagramAccount] {
                for account in accountsInContext {
                    account.selected = false
                    account.loggedIn = false
                }
            }
            }, completion: { (success) in
                
                let predicate = InstagramAccount.predicateForUnselectedInstagramAccounts()
                if let account = InstagramAccount.find(predicate) as? InstagramAccount {
                    AppCoreData.manager.selectInstagramAccount(account.objectId, completion: { (success) in
                        completion?(success, nil)
                    })
                }
                else {
                    AppNotifications.center.post(name: Notifications.noLoggedInAccounts)
                    completion?(success, nil)
                }
        })
    }
}

extension InstagramManager: InstagramNetworkClientManagerProtocol {
    var instagramAccessToken: String? {
        var result: String?
        if let currentUserId = InstagramAccount.selectedInstagramAccount?.objectId , isNeedToReceiveNewUser == false {
            result = keychainStore[kInstagramAccessToken + currentUserId]
        }
        else {
            result = keychainStore[kInstagramAccessToken]
        }
        return result
    }
}

extension InstagramManager: NotificationsObserverProtocol {
    func handle(_ notification: Notification) {
        if notification.name.rawValue == AppCoreDataManager.Notifications.didChangeInstagramAccount {
            cleanUpCachedMedia()
        }
    }
}

extension InstagramManager {
    struct Notifications {
        static let noLoggedInAccounts = "InstagramManagerNoLoggedInAccountsNotification"
        static let mediaWasChanged = "InstagramManagerMediaDidChangedNotification"
        static let accessTokenExpired = "InstagramManagerMediaAccessTokenExpired"
    }
}
