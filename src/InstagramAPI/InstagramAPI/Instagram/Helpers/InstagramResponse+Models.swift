//
//  AnyInstagramResponse+Models.swift
//  ConceptOffice
//
//  Created by Den Ree on 05/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import UIKit

// MARK: - InstagramPaginationInfo

struct InstagramPaginationInfo {
  // MARK: - Properties
  var nextURL: URL?
  var nextMaxId: String = ""
  init() {
    nextURL = nil
  }
}

// MARK: - InstagramMeta

struct InstagramMeta {
  // MARK: Nested 
  enum ErrorType: String {
    case empty = ""
    case accessTokenException = "OAuthAccessTokenException"
  }
  // MARK: - Properties
  var code: Int = 0
  var errorType: ErrorType = .empty
  var errorMessage: String = ""
  // MARK: - Public
  var isSucceeded: Bool {
    return code == 200
  }
}
