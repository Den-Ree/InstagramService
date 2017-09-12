//
//  MediaTest.swift
//  InstagramAPI
//
//  Created by Admin on 15.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import XCTest
@testable import InstagramAPI

class MediaTests: XCTestCase {

  func testGet() {
      let getMediaParameter = InstagramMediaRouter.MediaParameter.id("{media-id}")
      let getMediaRouter = InstagramMediaRouter.getMedia(getMediaParameter)
      guard let UrlRequest = try? getMediaRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Media.get.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testGetWithShortCode() {
      let getMediaWithShortCodeParameter = InstagramMediaRouter.MediaParameter.shortcode("D")
      let getMediaRouter = InstagramMediaRouter.getMedia(getMediaWithShortCodeParameter)
      guard let UrlRequest = try? getMediaRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Media.getWithShortCode.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testSearch() {
      let searchMediaParameter = InstagramMediaRouter.SearchMediaParameter.init(longitude: 0, latitude: 0, distance: 1)
      let searchMediaRouter = InstagramMediaRouter.search(searchMediaParameter)
      guard let UrlRequest = try? searchMediaRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Media.search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

}
