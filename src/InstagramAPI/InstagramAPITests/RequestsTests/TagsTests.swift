//
//  TagsTests.swift
//  InstagramAPI
//
//  Created by Admin on 15.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import XCTest
@testable import InstagramAPI

class TagsTests: XCTestCase {

  func testGet() {
      let getTagRouter = InstagramTagRouter.getTag(name: "{tag-name}")
      guard let UrlRequest = try? getTagRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Tag.get.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testGetRecent() {
      //swiftlint:disable:next line_length
      let getTagRecentParameter = InstagramTagRouter.RecentMediaParameter.init(tagName: "{tag-name}", minId: "0", maxId: "0", count: 0)
      let getTagRouter = InstagramTagRouter.getRecentMedia(getTagRecentParameter)
      guard let UrlRequest = try? getTagRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Tag.getRecent.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testSearch() {
      let searchTagRouter = InstagramTagRouter.search(query: "snowy")
      guard let UrlRequest = try? searchTagRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Tag.search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

}
