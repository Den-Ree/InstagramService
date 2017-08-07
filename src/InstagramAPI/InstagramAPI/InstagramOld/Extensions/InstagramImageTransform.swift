//
//  InstagramImageTransform.swift
//  InstagramAPI
//
//  Created by Admin on 04.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
import ObjectMapper

typealias InstagramImagesDictionary = [String: AnyObject]
typealias InstagramMediaURLDictionary = [String: AnyObject]

public struct InstagramImage {
  
    fileprivate(set) var lowResolutionURL: InstagramMediaURL?
    fileprivate(set) var standardResolutionURL: InstagramMediaURL?
    fileprivate(set) var thumbnailURL: InstagramMediaURL?
}

public struct InstagramMediaURL {
  
    fileprivate(set) var URL: Foundation.URL?
    fileprivate(set) var size: CGSize = CGSize.zero
  
    init(mediaURLDictionary: InstagramMediaURLDictionary?) {
      if let urlString = mediaURLDictionary?[Instagram.Keys.Data.url] as? String, let url = Foundation.URL(string: urlString), let width = mediaURLDictionary?[Instagram.Keys.Data.width] as? CGFloat, let height = mediaURLDictionary?[Instagram.Keys.Data.height] as? CGFloat {
        self.URL = url
        self.size = CGSize(width: width, height: height)
      }
  }
  
    //MARK: Public
    func convertToDictionary() -> InstagramMediaURLDictionary? {
      var result = InstagramMediaURLDictionary()
      if let urlString = URL?.absoluteString {
        result[Instagram.Keys.Data.url] = urlString as AnyObject?
      }
    
      result[Instagram.Keys.Data.width] = size.width as AnyObject?
      result[Instagram.Keys.Data.height] = size.height as AnyObject?
      return result
    }
}


open class InstagramImageTransform: TransformType {
  
    public typealias Object = InstagramImage
    public typealias JSON = [String: AnyObject]
  
    public init() {}
  
    open func transformFromJSON(_ value: Any?) -> InstagramImage? {
      guard let images = value as? InstagramImagesDictionary else {
        return nil
      }
    
      let lowResolutionURL = InstagramMediaURL(mediaURLDictionary: images[Instagram.Keys.Data.lowResolution] as? InstagramMediaURLDictionary)
      let standardResolutionURL = InstagramMediaURL(mediaURLDictionary: images[Instagram.Keys.Data.standardResolution] as? InstagramMediaURLDictionary)
      let thumbnailURL = InstagramMediaURL(mediaURLDictionary: images[Instagram.Keys.Data.thumbnail] as? InstagramMediaURLDictionary)
    
      return InstagramImage(lowResolutionURL: lowResolutionURL, standardResolutionURL: standardResolutionURL, thumbnailURL: thumbnailURL)
  }
  
    open func transformToJSON(_ value: InstagramImage?) -> [String: AnyObject]? {
      guard let image = value else {
        return nil
      }
      
      var imagesDictionary = InstagramImagesDictionary()
      if let lowResolutionURL = image.lowResolutionURL {
        imagesDictionary[Instagram.Keys.Data.lowResolution] = lowResolutionURL.convertToDictionary() as AnyObject?
      }
    
      if let standardResolution = image.standardResolutionURL {
        imagesDictionary[Instagram.Keys.Data.standardResolution] = standardResolution.convertToDictionary() as AnyObject?
      }
    
      if let thumbnailURL = image.thumbnailURL {
        imagesDictionary[Instagram.Keys.Data.thumbnail] = thumbnailURL.convertToDictionary() as AnyObject?
      }
    
      return imagesDictionary
    }
}
