//
//  InstagramLikeService.swift
//  ConceptOffice
//
//  Created by Denis on 03.04.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit

private let kInstagramCachedLikes = "kInstagramCachedLikes"
private let InstagramLikesStepCount = 3
private let InstagramMaxCount = 19

typealias InstagramLikesBlock = ([InstagramLike]?, Error?)->()

private class LikesCacheObject: NSObject {
    fileprivate(set) var isAllCached: Bool = false
    fileprivate(set) var totalLikesCount: Int = 0
    
    required init(totalLikesCount: Int) {
        super.init()
        self.totalLikesCount = totalLikesCount
    }
    
    var likes:[InstagramLike]?
    var paginationInfo: InstagramPaginationInfo? {
        didSet {
            if let likes = likes , likes.count == totalLikesCount {
                isAllCached = true
            }
        }
    }
}

//SERVICE
class InstagramLikeService: InstagramBaseService {
    //MARK: Properties
    fileprivate var cachedLikes: [String: LikesCacheObject] {
        get {
            if let cachedObjects = cachedObject as? [String: LikesCacheObject] {
                return cachedObjects
            }
            else {
                return [String: LikesCacheObject]()
            }
        }
        set(newValue) {
            cache(newValue as AnyObject?)
        }
    }
    
    //MARK: Public
    func fetchLikes(_ mediaId: String, range: InstagramPaginationRange, totalLikesCount: Int, completion: @escaping InstagramLikesBlock) {
        
        let currentCachedObject = cachedLikes[mediaId]
        //Check likes in cache
        guard currentCachedObject?.likes?.count != totalLikesCount else {
            completion(currentCachedObject?.likes, nil)
            return
        }
        
        if let likes = currentCachedObject?.likes , range.upperBound < likes.count {
            completion(cachedLikes(mediaId, range: range), nil)
        }
        else {
            //Calculate count
            var count = min(range.upperBound - range.lowerBound, totalLikesCount)
            if let cacheObject = currentCachedObject, let likes = cacheObject.likes {
                count -= likes.count
            }
            
            //Send request to get new likes
            sendLikesRequest(mediaId, count: count, maxId: currentCachedObject?.paginationInfo?.nextMaxId, completion: { [weak self] (likes: [InstagramLike]?, pagination: InstagramPaginationInfo?, error) in
                self?.cacheLikes(mediaId, totalLikesCount: totalLikesCount, newLikes: likes, paginationInfo: pagination)
                completion(self?.cachedLikes(mediaId, range: range), error)
            })
        }
    }
    
    func fetchAllLikes(_ mediaId: String, totalLikesCount: Int, completion: InstagramLikesBlock?) {
        
        var result = [InstagramLike]()
        //Start sending requests
        var likesGroup = DispatchGroup()
        //Get user followers
        likesGroup.enter()
        
        func incrementalFetchAllLikes() {
            //TODO: Need to set step count like totalLikesCount
            fetchLikes(mediaId, range: InstagramPaginationRange(0...InstagramLikesStepCount), totalLikesCount: totalLikesCount) { (likes: [InstagramLike]?, error) in
                if let likes = likes , likes.count > 0 {
                    result.append(contentsOf: likes)
                    if result.count < totalLikesCount {
                        incrementalFetchAllLikes()
                    }
                    else {
                        likesGroup.leave()
                    }
                }
                else {
                    likesGroup.leave()
                }
            }
        }
        
        incrementalFetchAllLikes()
        
        likesGroup.notify(queue: DispatchQueue.main, execute: {
            completion?(result, nil)
        })
    }
}

//MARK: Private
private extension InstagramLikeService {
    
    func cacheLikes(_ mediaId: String, totalLikesCount: Int, newLikes: [InstagramLike]?, paginationInfo: InstagramPaginationInfo?) {
        
        guard let newLikes = newLikes , newLikes.count > 0 else {
            return
        }
        var cachedObject = cachedLikes[mediaId]
        
        if cachedObject == nil {
            cachedObject = LikesCacheObject(totalLikesCount: totalLikesCount)
            cachedObject?.likes = newLikes
            cachedObject?.paginationInfo = paginationInfo
        }
        else {
            var result = [InstagramLike]()
            if let cachedLikes = cachedObject?.likes , cachedLikes.count > 0 {
                
                //Add cached media to result array, and update them newMedia contains them
                for cachedLikeObject in cachedLikes {
                    var resultObject = cachedLikeObject
                    for newLikeObject in newLikes {
                        if newLikeObject.objectId == cachedLikeObject.objectId {
                            resultObject = newLikeObject
                            break
                        }
                    }
                    result.append(resultObject)
                }
                
                //Add rest new media
                for newLikeObject in newLikes {
                    var isContained = false
                    for like in result {
                        if like.objectId == newLikeObject.objectId {
                            isContained = true
                        }
                    }
                    
                    if !isContained {
                        result.append(newLikeObject)
                    }
                }
                
            }
            else {
                result = newLikes
            }
            cachedObject?.likes = result
            cachedObject?.paginationInfo = paginationInfo
        }
        
        cachedLikes[mediaId] = cachedObject
    }
    
    /**
     Return objects in range, if range more then number of items it returns all list
     */
    func cachedLikes(_ mediaId: String, range: InstagramPaginationRange) -> [InstagramLike]? {
        
        guard let cachedLikes = cachedLikes[mediaId]?.likes else {
            return nil
        }
        
        let endIndex = min(cachedLikes.count - 1, range.upperBound)
        return Array(cachedLikes[range.lowerBound..<endIndex+1])
    }
    
    func sendLikesRequest(_ mediaId: String, count: Int, maxId: String?, completion: @escaping ([InstagramLike]?, InstagramPaginationInfo?, Error?) -> ()) {
        
        //Create parameteres
        var parameters = [InstagramRequestKey: AnyObject]()
        
        parameters[kInstagramCount] = count as AnyObject?
        if let maxId = maxId {
            parameters[kInstagramMaxId] = maxId as AnyObject?
        }
        
        networkClient.sendRequest(path: networkClient.instagramLikesPath(mediaId), parameters: parameters, bodyObject: nil) { (response: InstagramArrayResponse<InstagramLike>?, error) in
            let likes: [InstagramLike]? = response?.data
            let pagination: InstagramPaginationInfo? = response?.pagination
            
            completion(likes, pagination, error)
        }
    }
}

extension InstagramLikeService: InstagramCacheClient {
    var identifier: String {
        return kInstagramCachedLikes
    }
}
