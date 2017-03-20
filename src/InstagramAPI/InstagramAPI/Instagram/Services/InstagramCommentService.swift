//
//  InstagramCommentService.swift
//  ConceptOffice
//
//  Created by Denis on 20.03.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit

//Do it need to be added to Instagram constants
private let kInstagramCachedComments = "kInstagramCachedComments"
typealias InstagramCommentsBlock = ([Instagram.Comment]?, Error?)->()

class InstagramCommentService: InstagramBaseService {
    //MARK: Properties
    fileprivate var cachedComments: [String: [Instagram.Comment]] {
        get {
            if let cachedObjects = cachedObject as? [String: [Instagram.Comment]] {
                return cachedObjects
            }
            else {
              return [:]
            }
        }
        set(newValue) {
            cache(newValue as AnyObject?)
        }
    }
    
    //MARK: Public
    func fetchComments(_ mediaId: String, completion: @escaping InstagramCommentsBlock) {
        //Check media in cache
        if let cachedComments = cachedComments[mediaId] {
            completion(cachedComments, nil)
        }
        else {
            //Send request to get media comments
            sendCommentsRequest(mediaId: mediaId, completion: { [weak self] (comments :[Instagram.Comment]?, error: Error?) -> Void in
                self?.cachedComments[mediaId] = comments
                completion(comments, error)
            })
        }
    }
    
    func sendComment(_ mediaId: String, text: String, completion: @escaping InstagramSuccessBlock) {
        sendUserMediaCommentRequest(mediaId, text: text, completion: completion)
    }
}

private extension InstagramCommentService {
    
    func sendCommentsRequest(mediaId: String, completion: @escaping InstagramCommentsBlock) {
        networkClient.sendRequest(path: networkClient.instagramCommentsPath(mediaId), parameters: InstagramRequestParameters(), bodyObject: nil, completion: { (response: InstagramArrayResponse<Instagram.Comment>?, error) in
            
            InstagramManager.shared.checkAccessTokenExpirationInResponse(with: response?.meta)
            
            let comments: [Instagram.Comment]? = response?.data
            completion(comments, error)
        })
    }
    
    func sendUserMediaCommentRequest(_ mediaId: String, text: String, completion: @escaping InstagramSuccessBlock) {
        networkClient.sendRequest(.post, path: networkClient.instagramCommentsPath(mediaId), parameters: InstagramRequestParameters(), bodyObject: NetworkBodyObject(key: Instagram.Keys.Comment.text, value: text)) { [weak self] (response: InstagramMetaResponse?, error) in
            
            InstagramManager.shared.checkAccessTokenExpirationInResponse(with: response?.meta)
            var success = false
            if let result = response?.meta?.isSuccessCode , result {
                success = result
                self?.cachedComments[mediaId] = nil
                self?.fetchComments(mediaId, completion: { (_: [Instagram.Comment]?, error) in
                    completion(success, error)
                })
            }
            else {
                completion(success, error)
            }
        }
    }
}

extension InstagramCommentService: InstagramCacheClient {
    var identifier: String {
        return kInstagramCachedComments
    }
}


