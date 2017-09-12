//
//  UserRouterTest.swift
//  InstagramAPI
//
//  Created by Admin on 15.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import XCTest
@testable import InstagramAPI

class UserRouterTests: XCTestCase {

  func testGet() {
      let userParameter = InstagramUserRouter.UserParameter.id("{user-id}")
      let getUserRouter = InstagramUserRouter.getUser(userParameter)
      guard let UrlRequest = try? getUserRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.User.get.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testGetRecentMedia() {
      //swiftlint:disable:next line_length
      let recentMediaParameter = InstagramUserRouter.RecentMediaParameter.init(user: .id("{user-id}"), count: 0, minId: "0", maxId: "0")
      let getRecentMediaRouter = InstagramUserRouter.getRecentMedia(recentMediaParameter)
      guard let UrlRequest = try? getRecentMediaRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.User.getRecent.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testGetLikedMedia() {
      //swiftlint:disable:next line_length
      let getLikedMediaParameter = InstagramUserRouter.LikedMediaParameter.init(user: .id("{user-id}"), count: 0, maxLikeId: "0")
      let getLikedMediaRouter = InstagramUserRouter.getLikedMedia(getLikedMediaParameter)
      guard let UrlRequest = try? getLikedMediaRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.User.getLikedMedia.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testSearchUsers() {
      let searchUserParameter = InstagramUserRouter.SearchUserParameter.init(query: "jack", count: 0)
      let searchUserRouter = InstagramUserRouter.getSearch(searchUserParameter)
      guard let UrlRequest = try? searchUserRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.User.search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

}
