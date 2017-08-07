//
//  InstagramVideoTransform.swift
//  InstagramAPI
//
//  Created by Admin on 04.08.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import Foundation
import ObjectMapper

typealias InstagramVideosDictionary = [String: AnyObject]

public struct InstagramVideo {
  
    fileprivate(set) var lowResolutionURL: InstagramMediaURL?
    fileprivate(set) var standardResolutionURL: InstagramMediaURL?
    fileprivate(set) var lowBandwidthURL: InstagramMediaURL?
}

open class InstagramVideoTransform: TransformType {
  
    public typealias Object = InstagramVideo
    public typealias JSON = [String: AnyObject]
  
    public init() {}
  
    open func transformFromJSON(_ value: Any?) -> InstagramVideo? {
      guard let videos = value as? InstagramVideosDictionary else {
        return nil
      }
    
      let lowResolutionURL = InstagramMediaURL(mediaURLDictionary: videos[Instagram.Keys.Data.lowResolution] as? InstagramMediaURLDictionary)
      let standardResolutionURL = InstagramMediaURL(mediaURLDictionary: videos[Instagram.Keys.Data.standardResolution] as? InstagramMediaURLDictionary)
      let lowBandwidthURL = InstagramMediaURL(mediaURLDictionary: videos[Instagram.Keys.Data.lowBandwidth] as? InstagramMediaURLDictionary)
      
      return InstagramVideo(lowResolutionURL: lowResolutionURL, standardResolutionURL: standardResolutionURL, lowBandwidthURL: lowBandwidthURL)
    }
  
  open func transformToJSON(_ value: InstagramVideo?) -> [String: AnyObject]? {
      guard let video = value else {
        return nil
      }
    
      var videosDictionary = InstagramVideosDictionary()
      if let lowResolutionURL = video.lowResolutionURL {
        videosDictionary[Instagram.Keys.Data.lowResolution] = lowResolutionURL.convertToDictionary() as AnyObject?
      }
    
      if let standardResolution = video.standardResolutionURL {
        videosDictionary[Instagram.Keys.Data.standardResolution] = standardResolution.convertToDictionary() as AnyObject?
      }
    
      if let lowBandwidthURL = video.lowBandwidthURL {
        videosDictionary[Instagram.Keys.Data.lowBandwidth] = lowBandwidthURL.convertToDictionary() as AnyObject?
      }
    
      return videosDictionary
  }
}
