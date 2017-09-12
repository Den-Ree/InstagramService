//
//  LocationsTests.swift
//  InstagramAPI
//
//  Created by Admin on 15.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import XCTest
@testable import InstagramAPI

class LocationsTests: XCTestCase {

  func testGet() {
    let getLocationRouter = InstagramLocationRouter.getLocation(id: "{location-id}")
    guard let UrlRequest = try? getLocationRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
      return
    }
    //swiftlint:disable:next line_length
    XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Location.get.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testGetRecent() {
    //swiftlint:disable:next line_length
    let getLocationRecentParameter = InstagramLocationRouter.RecentMediaParameter.init(locationId: "{location-id}", minId: "0", maxId: "0")
    let getLocationRouter = InstagramLocationRouter.getRecentMedia(getLocationRecentParameter)
    guard let UrlRequest = try? getLocationRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
      return
    }
    //swiftlint:disable:next line_length
    XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Location.getRecent.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testSearch() {
    //swiftlint:disable:next line_length
    let searchLocationParameter = InstagramLocationRouter.SearchMediaParameter.init(longitude: 1, latitude: 1, distance: 1, facebookPlacesId: nil)
    let searchLocationRouter = InstagramLocationRouter.search(searchLocationParameter)
    guard let UrlRequest = try? searchLocationRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
      return
    }
    //swiftlint:disable:next line_length
    XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Location.search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

}
