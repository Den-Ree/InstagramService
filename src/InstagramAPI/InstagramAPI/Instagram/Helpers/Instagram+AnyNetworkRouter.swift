//
//  InstagramNetworkManager.swift
//  ConceptOffice
//
//  Created by Kirill Averyanov on 28/05/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import ObjectMapper
import Alamofire

enum InstagramNetworkError: Error {
  case wrongUrlComponents
  // MARK: - Protected
  var localizedDescription: String {
    switch self {
    case .wrongUrlComponents:
      return "Can't create request from url components"
    }
  }
}

protocol AnyNetworkRoutable {
  var path: String { get }
  var parameters: InstagramRequestParameters { get }
  var method: HTTPMethod { get }
}

protocol AnyInstagramNetworkRouter: AnyNetworkRoutable {
  func asURLRequest(withAccessToken: String) throws -> URLRequest
}

extension AnyInstagramNetworkRouter {
  // MARK: - AnyInstagramNetworkRouter
  func asURLRequest(withAccessToken accessToken: String) throws -> URLRequest {
    /// Setup path
    var urlComponents = Instagram.Constants.baseUrlComponents
    urlComponents.path = path
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
    if method != .post {
      let paramtersString = items.map({$0.name + "=" + ($0.value ?? "")}).joined(separator: "&")
      httpBody = paramtersString.data(using: .utf8)
    } else {
      urlComponents.queryItems = items
    }
    // Create request
    if let url = urlComponents.url {
      var request = URLRequest(url: url)
      request.httpMethod = method.rawValue
      request.httpBody = httpBody
      return request
    } else {
      throw InstagramNetworkError.wrongUrlComponents
    }
  }
}
