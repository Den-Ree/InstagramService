//
//  LikesTests.swift
//  InstagramAPI
//
//  Created by Admin on 15.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import XCTest
@testable import InstagramAPI

class LikesTests: XCTestCase {

  func testGet() {
      let getLikesRouter = InstagramLikeRouter.getLikes(mediaId: "{media-id}")
      guard let UrlRequest = try? getLikesRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Like.get.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testPost() {
      let postLikeRouter = InstagramLikeRouter.postLike(mediaId: "{media-id}")
      guard let UrlRequest = try? postLikeRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length force_cast
      guard let json = try? JSONSerialization.jsonObject(with: UrlRequest.httpBody!, options: .allowFragments) as! [String:Any] else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Like.post.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
      XCTAssert(json.parametersString() == TestConstants.HTTPBody.like)
      XCTAssert(UrlRequest.httpMethod == TestConstants.HTTPMethod.post)
  }

  func testDelete() {
      let deleteCommentRouter = InstagramLikeRouter.deleteLike(mediaId: "{media-id}")
      guard let UrlRequest = try? deleteCommentRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      //swiftlint:disable:next line_length
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Like.delete.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
      XCTAssert(UrlRequest.httpMethod == TestConstants.HTTPMethod.delete)
  }
}
