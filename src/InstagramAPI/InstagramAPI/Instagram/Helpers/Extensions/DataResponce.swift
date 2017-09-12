//
//  DataResponceExtension.swift
//  Pods
//
//  Created by Admin on 04.09.17.
//
//

import Foundation
import Alamofire

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
