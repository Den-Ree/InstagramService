//
//  InstagramMeta.swift
//  Pods
//
//  Created by Admin on 04.09.17.
//
//

import Foundation

// MARK: - InstagramMeta

public struct InstagramMeta {
  // MARK: Nested
  public enum ErrorType: String {
    case empty = ""
    case accessTokenException = "OAuthAccessTokenException"
  }
  // MARK: - Properties
  public var code: Int = 0
  public var errorType: ErrorType = .empty
  public var errorMessage: String = ""
  // MARK: - Public
  public var isSucceeded: Bool {
    return code == 200
  }
}
