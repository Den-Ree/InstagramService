//
//  InstagramCacheManager.swift
//  ConceptOffice
//
//  Created by Denis on 26.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit

protocol InstagramCacheClient: NSObjectProtocol {
    
    var identifier: String {get}
    var cachedObject: Any? {get}
    
    func cache(_ object: Any?)
}

extension InstagramCacheClient {

    var cachedObject: Any? {
        return InstagramCacheManager.shared.cachedObject(self)
    }
    
    func cache(_ object: Any?) {
        InstagramCacheManager.shared.cache(object, client: self)
    }
}

class InstagramCacheManager: NSObject {

    static let shared = InstagramCacheManager()
    
    fileprivate var cache = [String: Any]()
    
    //MARK: Public
    func cachedObject(_ client: InstagramCacheClient) -> Any? {
        if cache.count == 0 {
            return nil
        }
        else {
            return cache[client.identifier]
        }
    }
    
    func cache(_ object: Any?, client: InstagramCacheClient) {
        if let object = object {
            cache[client.identifier] = object
        }
        else {
            removeCachedObject([client])
        }
    }
    
    func removeCachedObject(_ clients: [InstagramCacheClient]) {
        var identifiers = [String]()
        for client in clients {
            cache.removeValue(forKey: client.identifier)
            identifiers.append(client.identifier)
        }
        if identifiers.count > 0 {
            AppNotifications.center.post(name: Notifications.didCleanClientsCache, userInfo: [Keys.clientIdentifiers : identifiers])
        }
    }
    
    func removeAllObjects() {
        cache.removeAll()
    }
}

extension InstagramCacheManager {
    struct Notifications {
        static let didCleanClientsCache = "InstagramCacheManagerCleanedClientsCacheNotification"
    }
    
    struct Keys {
        static let clientIdentifiers = "kInstagramCachedClientIdentifiers"
    }
}
