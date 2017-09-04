//
//  InstagramPaginationInfo.swift
//  Pods
//
//  Created by Admin on 04.09.17.
//
//

import Foundation

// MARK: - InstagramPaginationInfo

public struct InstagramPaginationInfo {
  // MARK: - Properties
  public var nextURL: URL?
  public var nextMaxId: String = ""
  public init() {
    nextURL = nil
  }
}
