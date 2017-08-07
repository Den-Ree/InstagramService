//
//  NetworkReachability.swift
//  ConceptOffice
//
//  Created by Denis on 21.07.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import Alamofire

class NetworkReachability: NSObject {

    static let shared = NetworkReachability()
    fileprivate lazy var previousState: Bool = {
        return self.hasConnection
    }()
    
    
    fileprivate lazy var reachabilityManager: NetworkReachabilityManager? = {
        let result = NetworkReachabilityManager()
        result?.listener = { (status) in
            if self.previousState != self.hasConnection {
                self.previousState = self.hasConnection
                self.notifyConnectionIsChanged()
            }
        }
        return result
    }()
    
    var hasConnection: Bool {
        if let result = reachabilityManager?.isReachable {
            return result
        }
        else {
            return false
        }
    }
    
    //MARK: Public
    func configure() {
        reachabilityManager?.startListening()
    }
    
    func checkConnection() {
        if !hasConnection {
            notifyConnectionIsChanged()
        }
    }
}

private extension NetworkReachability {
    
    func notifyConnectionIsChanged() {
        //TODO: 
    }
}

extension NetworkReachability {
    struct Notifications {
        static let reachabilityStatusDidChange = "NetworkReachabilityReachabilityStatusDidChangeNotification"
    }
}
