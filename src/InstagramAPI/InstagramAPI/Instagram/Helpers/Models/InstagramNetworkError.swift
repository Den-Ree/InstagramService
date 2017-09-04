//
//  InstagramNetworkError.swift
//  Pods
//
//  Created by Admin on 04.09.17.
//
//

import Foundation

public enum InstagramNetworkError: Error {
  case wrongUrlComponents
  // MARK: - Protected
  public var localizedDescription: String {
    switch self {
    case .wrongUrlComponents:
      return "Can't create request from url components"
    }
  }
}
