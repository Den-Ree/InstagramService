//
//  InstagramTagService.swift
//  ConceptOffice
//
//  Created by Denis on 06.04.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit

typealias InstagramTagBlock = (Instagram.Tag?, Error?)->()
typealias InstagramTagsBlock = ([Instagram.Tag]?, Error?)->()

class InstagramTagService: InstagramBaseService {
    
    func fetchTags(with tagNames:[String]?, completion: @escaping InstagramTagsBlock) {
        guard let tagNames = tagNames else {
            completion(nil, nil)
            return
        }
        
        //Create requests group
        let tagsGroup = DispatchGroup()
        var tags: [Instagram.Tag] = []
        var tagsError: Error?
        
        tagsGroup.enter()
        for tagString in tagNames {
            tagsGroup.enter()
            sendTagRequest(tagString, completion: { (tag: Instagram.Tag?, error: Error?) in
                if let tag = tag {
                    tags.append(tag)
                }
                else if let error = error {
                    tagsError = error
                }
                
                tagsGroup.leave();
            })
        }
        tagsGroup.leave()

        tagsGroup.notify(queue: DispatchQueue.main, execute: {
            completion(tags, tagsError)
        })
    }
    
    func fetchTags(searchText: String?, completion: @escaping InstagramTagsBlock) {
        guard let searchText = searchText else {
            completion(nil, nil)
            return
        }
        
        sendTagsRequest(searchText) { (tags: [Instagram.Tag]?, error: Error?) in
            completion(tags, error)
        }
    }
}

private extension InstagramTagService {
    
    func sendTagRequest(_ name: String, completion: @escaping InstagramTagBlock) {
        networkClient.sendRequest(path: networkClient.instagramTagsPath(name), parameters: InstagramRequestParameters(), bodyObject: nil) { (response: InstagramObjectResponse <Instagram.Tag>?, error) in
            let tag: Instagram.Tag? = response?.data
            completion(tag, error)
        }
    }
    
    func sendTagsRequest(_ searchText: String, completion: @escaping InstagramTagsBlock) {
        var parameters = [InstagramRequestKey: AnyObject]()
        parameters["q"] = searchText as AnyObject?
        networkClient.sendRequest(path: networkClient.instagramSearchTagsPath(), parameters: parameters, bodyObject: nil) { (response: InstagramArrayResponse<Instagram.Tag>?, error) in
            let tags: [Instagram.Tag]? = response?.data
            completion(tags, error)
        }
    }
}
