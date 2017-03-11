//
//  InstagramMediaService.swift
//  ConceptOffice
//
//  Created by Denis on 25.02.16.
//  Copyright © 2016 Den Ree. All rights reserved.
//

import UIKit
//Do it need to be added to Instagram constrains
private let kInstagramCachedMedia = "kInstagramCachedMedia"
private let instagramDefaultDayMediaCount = 3
private let instagramMediaMaxCount = 19

typealias InstagramMediaBlock = ([InstagramMedia]?, Error?)->()
typealias InstagramMediaPaginationBlock = ([InstagramMedia]?, InstagramPaginationInfo?, Error?)->()

private class MediaCacheObject: NSObject {
    fileprivate(set) var isAllCached: Bool = false
    fileprivate(set) var totalMediaCount: Int = 0
    
    required init(totalMediaCount: Int) {
        super.init()
        self.totalMediaCount = totalMediaCount
    }
    
    var media:[InstagramMedia]? {
        didSet {
            if let media = media , media.count == totalMediaCount {
                isAllCached = true
            }
        }
    }
    var paginationInfo: InstagramPaginationInfo?
}

//SERVICE
class InstagramMediaService: InstagramBaseService {
    //MARK: Properties
    fileprivate var cachedMedia: [String: MediaCacheObject] {
        get {
            if let cachedObjects = cachedObject as? [String: MediaCacheObject] {
                return cachedObjects
            }
            else {
                return [String: MediaCacheObject]()
            }
        }
        set(newValue) {
            cache(newValue as AnyObject?)
        }
    }
    
    //MARK: Public
    func fetchMedia(forLoggedInUser userId: String, range: InstagramPaginationRange, totalMediaCount: Int, completion: @escaping InstagramMediaBlock) {
        
        let currentCachedObject = cachedMedia[userId]
        if let count = currentCachedObject?.media?.count, count >= totalMediaCount {
            completion(cachedMedia(userId, range: range), nil)
            return
        }

        if let media = currentCachedObject?.media , range.upperBound < media.count {
            completion(cachedMedia(userId, range: range), nil)
        }
        else {
            //Calculate count
            var count = min(range.upperBound - range.lowerBound, totalMediaCount - range.lowerBound)
            
            if let cacheObject = currentCachedObject, let media = cacheObject.media , range.lowerBound < media.count {
                count -= (media.count - range.lowerBound)
            }
            
            //Send request to get new media
            sendMediaRequest(forUser: userId, count: count, maxId: currentCachedObject?.paginationInfo?.nextMaxId) { [weak self] (media: [InstagramMedia]?, paginationInfo: InstagramPaginationInfo?, error) -> Void in
                self?.cacheMedia(userId, totalMediaCount: totalMediaCount, newMedia: media, paginationInfo: paginationInfo)
                completion(self?.cachedMedia(userId, range: range), error)
            }
        }
    }

    
    func fetchMedia(forLoggedInUser userId: String?, startDate: Date, endDate: Date, totalMediaCount: Int, completion: InstagramMediaBlock?) {
        guard startDate < endDate else {
            completion?(nil, nil)
            return
        }
        
        guard let userId = userId, totalMediaCount > 0 else {
            completion?(nil, nil)
            return
        }
    
        if let latestMedia = latestCachedMedia(userId), let earliestMedia = earliestCachedMedia(userId), let latestCreatedDate = latestMedia.createdDate, let earliestCreatedDate = earliestMedia.createdDate, let isAllCached = cachedMedia[userId]?.isAllCached {
            if (startDate > latestCreatedDate && earliestCreatedDate <= endDate) || isAllCached {
                completion?(cachedMedia(userId, startDate: startDate, endDate: endDate), nil)
            }
            else {
                
                let resultStart = (startDate as NSDate).earlierDate(earliestCreatedDate as Date)
                let resultEnd = (endDate as NSDate).laterDate(latestCreatedDate as Date)
                
                let timeInterval: TimeInterval = resultEnd.timeIntervalSince(resultStart)
                var startIndex = 0
                if let cachedMedia = cachedMedia[userId]?.media , cachedMedia.count > 0 {
                    startIndex = cachedMedia.count - 1
                }
                
                let stepValue = min(instagramMediaMaxCount,  timeInterval.days * instagramDefaultDayMediaCount)
                fetchMedia(forLoggedInUser: userId, range: InstagramPaginationRange(startIndex...startIndex + stepValue), totalMediaCount: totalMediaCount, completion: { [weak self] (newMedia: [InstagramMedia]?, error) -> () in
                    if error == nil && newMedia == nil {
                        completion?(self?.cachedMedia(userId, startDate: startDate, endDate: endDate), nil)
                    }
                    else {
                        self?.fetchMedia(forLoggedInUser: userId, startDate: startDate, endDate: endDate, totalMediaCount: totalMediaCount, completion: completion)
                    }
                })
            }
        }
        else {
            let timeInterval = min(instagramMediaMaxCount, Int(endDate.timeIntervalSince(startDate)))
            fetchMedia(forLoggedInUser: userId, range: InstagramPaginationRange(0...timeInterval), totalMediaCount: totalMediaCount, completion: { [weak self] (newMedia: [InstagramMedia]?, error) -> () in
                if let error = error {
                    completion?(nil, error)
                }
                else {
                    self?.fetchMedia(forLoggedInUser: userId, startDate: startDate, endDate: endDate, totalMediaCount: totalMediaCount, completion: completion)
                }
            })
        }
    }
    
    func fetchMedia(forTag name: String, nextMaxId: String?, range: InstagramPaginationRange, completion: @escaping InstagramMediaPaginationBlock) {
    
        //Send request to get new media
        sendMediaRequest(forTag: name, count: range.upperBound - range.lowerBound, maxId: nextMaxId) { (media: [InstagramMedia]?, paginationInfo: InstagramPaginationInfo?, error) -> Void in
            completion(media, paginationInfo, error)
        }
    }
    
    func fetchMedia(forUser userId: String, nextMaxId: String?, range: InstagramPaginationRange,completion: @escaping InstagramMediaPaginationBlock) {
        //Send request to get new media
        sendMediaRequest(forUser: userId, count: range.upperBound - range.lowerBound, maxId: nextMaxId) { (media: [InstagramMedia]?, paginationInfo: InstagramPaginationInfo?, error) -> Void in
            completion(media, paginationInfo, error)
        }
    }
    
    func sendMediaRequest(forUser userId: String?, count: Int, maxId: String?, completion: (([InstagramMedia]?, InstagramPaginationInfo?, Error?) -> Void)?) {
        guard count > 0 else {
            completion?(nil,nil,nil)
            return
        }
        
        //Create parameteres
        var parameters = [InstagramRequestKey: AnyObject]()
        
        parameters[Instagram.Keys.Media.count] = count as AnyObject?
        if let maxId = maxId {
            parameters[Instagram.Keys.Pagination.maxId] = maxId as AnyObject?
        }
        
        networkClient.sendRequest(path: networkClient.instagramUserMediaPath(userId), parameters: parameters, bodyObject: nil) { (response: InstagramArrayResponse<InstagramMedia>?, error) in
            let media: [InstagramMedia]? = response?.data
            let pagination: InstagramPaginationInfo? = response?.pagination
            InstagramManager.shared.checkAccessTokenExpirationInResponse(with: response?.meta)
            completion?(media, pagination, error)
        }
    }
    
    func sendMediaLikedRequest(count: Int, maxLikeID: String?, completion: (([InstagramMedia]?, InstagramPaginationInfo?, Error?) -> Void)?) {
        guard count > 0 else {
            completion?(nil,nil,nil)
            return
        }
        
        //Create parameteres
        var parameters = [InstagramRequestKey: AnyObject]()
        
        parameters[Instagram.Keys.Media.count] = count as AnyObject?
        if let maxLikeID = maxLikeID {
            parameters[Instagram.Keys.Pagination.maxLikeId] = maxLikeID as AnyObject?
        }
        
        networkClient.sendRequest(path: networkClient.instagramUserMediaLikedPath(), parameters: parameters, bodyObject: nil) { (response: InstagramArrayResponse<InstagramMedia>?, error) in
            let media: [InstagramMedia]? = response?.data
            let pagination: InstagramPaginationInfo? = response?.pagination
            InstagramManager.shared.checkAccessTokenExpirationInResponse(with: response?.meta)
            completion?(media, pagination, error)
        }
    }
}

//MARK: Private
private extension InstagramMediaService {
    
    func cacheMedia(_ userId: String, totalMediaCount: Int, newMedia: [InstagramMedia]?, paginationInfo: InstagramPaginationInfo?) {
        guard let newMedia = newMedia , newMedia.count > 0 else {
            return
        }
        
        var cachedObject = cachedMedia[userId]
        
        if cachedObject == nil {
            cachedObject = MediaCacheObject(totalMediaCount: totalMediaCount)
            cachedObject?.media = newMedia
            cachedObject?.totalMediaCount = totalMediaCount
            cachedObject?.paginationInfo = paginationInfo
        }
        else {
            var result = [InstagramMedia]()
            if let cachedMedia = cachedObject?.media , cachedMedia.count > 0 {
                
                //Add cached media to result array, and update them newMedia contains them
                for cachedMediaObject in cachedMedia {
                    var resultObject = cachedMediaObject
                    for newMediaObject in newMedia {
                        if newMediaObject.objectId == cachedMediaObject.objectId {
                            resultObject = newMediaObject
                            break
                        }
                    }
                    result.append(resultObject)
                }
                
                //Add rest new media
                for newMediaObject in newMedia {
                    var isContained = false
                    for media in result {
                        if media.objectId == newMediaObject.objectId {
                            isContained = true
                        }
                    }
                    
                    if !isContained {
                        result.append(newMediaObject)
                    }
                }
                
            }
            else {
                result = newMedia
            }
            cachedObject?.media = result
            cachedObject?.paginationInfo = paginationInfo
        }
        
        cachedMedia[userId] = cachedObject
    }

    /**
     Return objects in range, if range more then number of items it returns all list
     */
    func cachedMedia(_ userId: String, range: InstagramPaginationRange) -> [InstagramMedia]? {
        
        guard let cachedMedia = cachedMedia[userId]?.media else {
            return nil
        }
        
        let endIndex = min(cachedMedia.count - 1, range.upperBound)
        if range.lowerBound < endIndex && endIndex > 0 && endIndex < cachedMedia.count {
            return Array(cachedMedia[range.lowerBound...endIndex])
        }
        else {
            return nil
        }
    }
    
    func cachedMedia(_ userId: String, startDate: Date, endDate: Date) -> [InstagramMedia]? {
        guard let cachedMedia = cachedMedia[userId]?.media else {
            return nil
        }
        
        let filteredMedia = cachedMedia.filter { (media: InstagramMedia) -> Bool in
            if let createdDate = media.createdDate {
                return  startDate <= createdDate && createdDate <= endDate
            }
            else {
                return false
            }
        }
        
        return filteredMedia
    }
    
    func earliestCachedMedia(_ userId: String) -> InstagramMedia? {
        guard let cachedMedia = cachedMedia[userId]?.media else {
            return nil
        }
        
        return cachedMedia.first
    }
    
    func latestCachedMedia(_ userId: String) -> InstagramMedia? {
        guard let cachedMedia = cachedMedia[userId]?.media else {
            return nil
        }
        
        return cachedMedia.last
    }
    
    func sendMediaRequest(forTag name: String, count: Int, maxId: String?, completion: (([InstagramMedia]?, InstagramPaginationInfo?, Error?) -> Void)?) {
        guard count > 0 else {
            completion?(nil,nil,nil)
            return
        }
        
        //Create parameteres
        var parameters = [InstagramRequestKey: AnyObject]()
        
        parameters[Instagram.Keys.Media.count] = count as AnyObject?
        if let maxId = maxId {
            parameters[Instagram.Keys.Pagination.maxId] = maxId as AnyObject?
        }
        
        networkClient.sendRequest(path: networkClient.instagramTagMediaPath(name), parameters: parameters, bodyObject: nil) { (response: InstagramArrayResponse<InstagramMedia>?, error) in
            let media: [InstagramMedia]? = response?.data
            let pagination: InstagramPaginationInfo? = response?.pagination
            
            completion?(media, pagination, error)
        }
    }
}

extension InstagramMediaService: InstagramCacheClient {
    var identifier: String {
        return kInstagramCachedMedia
    }
}
