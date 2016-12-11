//
//  InstagramTagService.swift
//  ConceptOffice
//
//  Created by Denis on 06.04.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit

typealias InstagramTagBlock = (InstagramTag?, Error?)->()
typealias InstagramTagsBlock = ([InstagramTag]?, Error?)->()

class InstagramTagService: InstagramBaseService {
    
    func fetchTags(with tagNames:[String]?, completion: @escaping InstagramTagsBlock) {
        guard let tagNames = tagNames else {
            completion(nil, nil)
            return
        }
        
        //Create requests group
        let tagsGroup = DispatchGroup()
        var tags = [InstagramTag]()
        var tagsError: Error?
        
        tagsGroup.enter()
        for tagString in tagNames {
            tagsGroup.enter()
            sendTagRequest(tagString, completion: { (tag: InstagramTag?, error: Error?) in
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
        
        sendTagsRequest(searchText) { (tags: [InstagramTag]?, error: Error?) in
            completion(tags, error)
        }
    }
}

private extension InstagramTagService {
    
    func sendTagRequest(_ name: String, completion: @escaping InstagramTagBlock) {
        networkClient.sendRequest(path: networkClient.instagramTagsPath(name), parameters: InstagramRequestParameters()) { (response: InstagramObjectResponse <InstagramTag>?, error) in
            let tag: InstagramTag? = response?.data
            completion(tag, error)
        }
    }
    
    func sendTagsRequest(_ searchText: String, completion: @escaping InstagramTagsBlock) {
        var parameters = [InstagramRequestKey: AnyObject]()
        parameters["q"] = searchText as AnyObject?
        networkClient.sendRequest(path: networkClient.instagramSearchTagsPath(), parameters: parameters) { (response: InstagramArrayResponse<InstagramTag>?, error) in
            let tags: [InstagramTag]? = response?.data
            completion(tags, error)
        }
    }
}
