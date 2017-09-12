//
//  InstagramMedia.swift
//  ConceptOffice
//
//  Created by Denis on 23.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import ObjectMapper

public struct InstagramMedia: AnyInstagramModel {
  // MARK: - Nested
  public enum MediaType: String {
    case image
    case video
  }
  public struct Image {
    public var lowResolution = InstagramMedia.Url()
    public var standardResolution = InstagramMedia.Url()
    public var thumbnail = InstagramMedia.Url()
  }
  public struct Video {
    public var lowResolution = InstagramMedia.Url()
    public var standardResolution = InstagramMedia.Url()
    public var lowBandwidth = InstagramMedia.Url()
  }
  public struct Url {
    public var url: URL?
    public var size: CGSize = .zero
  }
  // MARK: - Properties
  //swiftlint:disable:next identifier_name
  public var id: String = ""
  public var user = InstagramUser()
  public var userHasLiked: Bool = false
  public var createdDate: Date = Date()
  public var link: String = ""
  public var caption = InstagramComment()
  public var tagsCount: Int = 0
  public var likesCount: Int = 0
  public var commentsCount: Int = 0
  public var location = InstagramLocation()
  public var type = MediaType.image
  public var image: Image = Image()
  public var video: Video = Video()
  public var tags: [String] = []
  // MARK: - Public
  public var isVideo: Bool {
    return type == .video
  }
}
