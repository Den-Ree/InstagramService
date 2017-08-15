//
//  CommentTests.swift
//  
//
//  Created by Admin on 15.08.17.
//
//

import XCTest
@testable import InstagramAPI

class CommentTests: XCTestCase {

  func testGet() {
      let getCommentRouter = InstagramCommentRouter.getComments(mediaId: "{media-id}")
      guard let UrlRequest = try? getCommentRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Comment.get.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
  }

  func testPost() {
      let postCommentParameter = InstagramCommentRouter.PostCommentParameter.init(mediaId: "{media-id}", text: "This is my comment")
      let postCommentRouter = InstagramCommentRouter.postComment(postCommentParameter)
      guard let UrlRequest = try? postCommentRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      guard let json = try? JSONSerialization.jsonObject(with: UrlRequest.httpBody!, options: .allowFragments) as!  [String:Any] else {
        return
      }
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Comment.post.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
      XCTAssert(UrlRequest.httpMethod == TestConstants.HTTPMethod.post)
      XCTAssert(json.parametersString() == TestConstants.HTTPBody.comment)
  }

  func testDelete() {
      let deleteCommentParameter = InstagramCommentRouter.DeleteCommentParameter.init(mediaId: "{media-id}", commentId:"{comment-id}")
      let deleteCommentRouter = InstagramCommentRouter.deleteComment(deleteCommentParameter)
      guard let UrlRequest = try? deleteCommentRouter.asURLRequest(withAccessToken: "ACCESS-TOKEN") else {
        return
      }
      XCTAssert(UrlRequest.url?.absoluteString == TestConstants.URL.Comment.delete.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
      XCTAssert(UrlRequest.httpMethod == TestConstants.HTTPMethod.delete)
  }

}
