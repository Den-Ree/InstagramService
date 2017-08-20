//
//  LikesEndpoint.swift
//  ConceptOffice
//
//  Created by Kirill Averyanov on 28/05/2017.
//  Copyright © 2017 Den Ree. All rights reserved.
//

public enum InstagramLikeRouter: AnyInstagramNetworkRouter {
  // MARK: - Requests
  case getLikes(mediaId: String)
  case postLike(mediaId: String)
  case deleteLike(mediaId: String)
}
