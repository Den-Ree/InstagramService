//
//  InstagramNetworkManager.swift
//  ConceptOffice
//
//  Created by Kirill Averyanov on 28/05/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import ObjectMapper
import Alamofire

public extension AnyInstagramNetworkRouter {
  // MARK: - AnyInstagramNetworkRouter
  public func asURLRequest(withAccessToken accessToken: String) throws -> URLRequest {
    /// Setup path
    var urlComponents = Instagram.Constants.baseUrlComponents
    urlComponents.path = "/v1" + path
    /// Setup parameters
    var items = [URLQueryItem]()
    items.append(URLQueryItem(name: Instagram.Keys.Auth.accessToken, value: accessToken))
    if parameters.count > 0 {
      parameters.forEach({ (parameter) in
        let item = URLQueryItem(name: parameter.key, value: "\(parameter.value)")
        items.append(item)
      })
    }
    // Fill parameters
    var httpBody: Data?
    if method == .post {
      let parametersString = items.map({$0.name + "=" + ($0.value ?? "")}).joined(separator: "&")
      httpBody = parametersString.data(using: .utf8)
    } else {
      urlComponents.queryItems = items
    }
    // Create request
    if let url = urlComponents.url {
      print(url)
      var request = URLRequest(url: url)
      request.httpMethod = method.rawValue
      request.httpBody = httpBody
      return request
    } else {
      throw InstagramNetworkError.wrongUrlComponents
    }
  }
}

extension AnyInstagramNetworkRouter {

  public func describe() {
    print("\n")
    print("Instagram Network Router Description...")
    print("Path: \(self.path)")
    if self.parameters.isEmpty {
      print("Parameters: nil")
    } else {
      print("Parameters: \(self.parameters)")
    }
    print("HTTPMethod: \(self.method)")
  }
}
