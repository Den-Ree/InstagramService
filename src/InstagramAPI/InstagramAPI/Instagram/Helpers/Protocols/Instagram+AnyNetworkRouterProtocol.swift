//
//  Instagram+AnyNetworkRouterProtocol.swift
//  Pods
//
//  Created by Admin on 04.09.17.
//
//

import Foundation
import Alamofire

public protocol AnyNetworkRoutable {
  var path: String { get }
  var parameters: InstagramRequestParameters { get }
  var method: HTTPMethod { get }
}

public protocol AnyInstagramNetworkRouter: AnyNetworkRoutable {
  func asURLRequest(withAccessToken: String) throws -> URLRequest
}
