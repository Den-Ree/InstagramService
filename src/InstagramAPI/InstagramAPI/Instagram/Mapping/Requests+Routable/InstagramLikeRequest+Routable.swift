//
//  InstagramLikeRequest+Routable.swift
//  ConceptOffice
//
//  Created by Den Ree on 06/08/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import Alamofire

extension InstagramLikeRouter: AnyNetworkRoutable {
  // MARK: - Private
  public var method: HTTPMethod {
    switch self {
    case .getLikes:
      return .get
    case .postLike:
      return .post
    case .deleteLike:
      return .delete
    }
  }
  public var path: String {
    switch self {
    case let .getLikes(mediaId),
         let .postLike(mediaId),
         let .deleteLike(mediaId):
      return "/media/\(mediaId)/likes"
    }
  }
  public var parameters: InstagramRequestParameters {
    return [:]
  }
}
