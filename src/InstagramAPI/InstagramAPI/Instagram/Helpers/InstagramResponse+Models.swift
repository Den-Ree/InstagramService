//
//  AnyInstagramResponse+Models.swift
//  ConceptOffice
//
//  Created by Den Ree on 05/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import UIKit

// MARK: - InstagramPaginationInfo

public struct InstagramPaginationInfo {
  // MARK: - Properties
  public var nextURL: URL?
  public var nextMaxId: String = ""
  public init() {
    nextURL = nil
  }
}

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
