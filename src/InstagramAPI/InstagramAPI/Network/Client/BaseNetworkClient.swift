
//  BaseNetworkClient.swift
//  ConceptOffice
//
//  Created by Denis on 05.05.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import Timberjack

typealias NetworkBodyObject = (key: String, value: String)

class HTTPManager: Alamofire.SessionManager {
    static let shared: HTTPManager = {
        let configuration = Timberjack.defaultSessionConfiguration()
        let manager = HTTPManager(configuration: configuration)
        return manager
    }()
}

class BaseNetworkClient: NSObject {
    
    func sendRequest<T: Mappable>(_ method: HTTPMethod = .get, path: String?, parameters: [String: AnyObject], completion: @escaping (T?, Error?)->()) {
        
        if !NetworkReachability.shared.hasConnection {
            NetworkReachability.shared.checkConnection()
        }
        
        //encode url and send request
        if let pathURL = encode(path, parameters: parameters) {
            //TODO: need to check encode method
            HTTPManager.shared.request(pathURL, method: method).responseObject { (response: Alamofire.DataResponse<T>) -> Void in
                completion(response.result.value, response.result.error)
            }
        } else {
            completion(nil, nil)
        }
    }
    
    func sendRequest<T: Mappable>(_ method: HTTPMethod = .get, path: String?, parameters: [String: AnyObject], bodyObject: NetworkBodyObject, completion: @escaping (T?, Error?)->()) {
        
        if !NetworkReachability.shared.hasConnection {
            NetworkReachability.shared.checkConnection()
        }
        
        if let pathURL = encode(path, parameters: parameters) {
            do {
                var request = try URLRequest(url: pathURL, method: method)
                let bodyString = bodyObject.key + "=" + bodyObject.value
                request.httpBody = bodyString.data(using: String.Encoding.utf8, allowLossyConversion: false)
                HTTPManager.shared.request(request).responseObject(completionHandler: { (response: Alamofire.DataResponse<T>) -> Void in
                    completion(response.result.value, response.result.error)
                })
            } catch {
                completion(nil, error)
            }
        } else {
            completion(nil, nil)
        }
    }
    
    //Convert path with parameteres in request url
    //TODO: Need to think about destination
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
