//
//  InstagramMedia.swift
//  ConceptOffice
//
//  Created by Denis on 23.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import ObjectMapper

struct InstagramMedia: AnyInstagramModel {
  // MARK: - Nested
  enum MediaType: String {
    case image
    case video
  }
  struct Image {
    var lowResolution = InstagramMedia.Url()
    var standardResolution = InstagramMedia.Url()
    var thumbnail = InstagramMedia.Url()
  }
  struct Video {
    var lowResolution = InstagramMedia.Url()
    var standardResolution = InstagramMedia.Url()
    var lowBandwidth = InstagramMedia.Url()
  }
  struct Url {
    var url: URL?
    var size: CGSize = .zero
  }
  // MARK: - Properties
  var id: String = ""
  var user = InstagramUser()
  var userHasLiked: Bool = false
  var createdDate: Date = Date()
  var link: String = ""
  var caption = InstagramComment()
  var tagsCount: Int = 0
  var likesCount: Int = 0
  var commentsCount: Int = 0
  var location = InstagramLocation()
  var type = MediaType.image
  var image: String = ""
  var video: String = ""
  var tags: [String] = []
  // MARK: - Public
  var isVideo: Bool {
    return type == .video
  }
}
