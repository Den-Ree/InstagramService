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

  let getLocation = "https://api.instagram.com/v1/locations/{location-id}?access_token=ACCESS-TOKEN"
  let getLocationRecent = "https://api.instagram.com/v1/locations/{location-id}/media/recent?access_token=ACCESS-TOKEN&max_id=0&min_id=0"
  let searchLocation = "https://api.instagram.com/v1/locations/search?access_token=ACCESS-TOKEN&lng=1&lat=1&distance=1"

  func testGet() {
    let getLocationRouter = InstagramLocationRouter.getLocation(id: "{location-id}")
    guard let UrlRequest = try? getLocationRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
      return
    }
    XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Location.get.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testGetRecent() {
    let getLocationRecentParameter = InstagramLocationRouter.RecentMediaParameter.init(locationId: "{location-id}", minId: "0", maxId: "0")
    let getLocationRouter = InstagramLocationRouter.getRecentMedia(getLocationRecentParameter)
    guard let UrlRequest = try? getLocationRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
      return
    }
    XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Location.getRecent.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testSearch() {
    let searchLocationParameter = InstagramLocationRouter.SearchMediaParameter.init(longitude: 1, latitude: 1, distance: 1, facebookPlacesId: nil)
    let searchLocationRouter = InstagramLocationRouter.search(searchLocationParameter)
    guard let UrlRequest = try? searchLocationRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
      return
    }
    XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Location.search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

}
