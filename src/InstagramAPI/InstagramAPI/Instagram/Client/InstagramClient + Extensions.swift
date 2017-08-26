//
//  InstagramClient + Extensions.swift
//  Pods
//
//  Created by Admin on 26.08.17.
//
//

import Foundation
import Alamofire

extension InstagramClient {
  
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

extension URLRequest {
  // MARK: Request description
  func description(router: AnyInstagramNetworkRouter) {
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

extension DataResponse {
  
  func description() {
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

extension Dictionary {
  
  func parametersString() -> String {
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
