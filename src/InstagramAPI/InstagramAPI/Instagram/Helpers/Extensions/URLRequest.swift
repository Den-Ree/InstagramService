//
//  URLRequest.swift
//  Pods
//
//  Created by Admin on 04.09.17.
//
//

import Foundation

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
      // swiftlint:disable:next force_cast line_length
      guard let json = try? JSONSerialization.jsonObject(with: self.httpBody!, options: .allowFragments) as! [String:Any] else {
        return
      }
      print("HTTP Body: \(json)")
    } else {
      print("HTTP Body: nil")
    }
  }
}
