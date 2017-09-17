//
//  RelationshipRouterTest.swift
//  InstagramAPI
//
//  Created by Admin on 15.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import XCTest
@testable import InstagramAPI

class RelationshipRouterTests: XCTestCase {

  func testGetFollows() {
      let getFollowsRouter = InstagramRelationshipRouter.getFollows
      guard let UrlRequest = try?  getFollowsRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Relationship.getFollows.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testGetFollowedBy() {
      let getFollowedByRouter = InstagramRelationshipRouter.getFollowedBy
      guard let UrlRequest = try? getFollowedByRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Relationship.getFollowedBy.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testGetRequestedBy() {
      let getRequestedByRouter = InstagramRelationshipRouter.getRequestedBy
      guard let UrlRequest = try? getRequestedByRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Relationship.getRequestedBy.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testGetRelationship() {
      let getRelationshipRouter = InstagramRelationshipRouter.getRelationship(userId: "{user-id}")
      guard let UrlRequest = try? getRelationshipRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Relationship.getRelationship.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testPost() {
      //swiftlint:disable:next line_length
      let postRelationshipParameter = InstagramRelationshipRouter.PostRelationshipParameter.init(userId: "{user-id}", action: .follow)
      let postRelationshipRouter = InstagramRelationshipRouter.postRelationship(postRelationshipParameter)
      guard let UrlRequest = try? postRelationshipRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length, force_cast
      guard let json = try? JSONSerialization.jsonObject(with: UrlRequest.httpBody!, options: .allowFragments) as! [String: Any] else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Relationship.post.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
      XCTAssert(UrlRequest.httpMethod == TestConstants.HTTPMethod.post)
      XCTAssert(json.parametersString() == TestConstants.HTTPBody.relationship)
  }

}
