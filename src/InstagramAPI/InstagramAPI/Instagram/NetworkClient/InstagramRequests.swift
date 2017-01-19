//
//  InstagramRequests.swift
//  InstagramAPI
//
//  Created by Denis on 16.01.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

typealias InstagramObjectId = String


/**
 Common class of Endpoints
 */
enum Instagram {}

//MARK: USERS
extension Instagram {
    
    enum UsersEndpoint {
        
        
        //Requests
        enum Get: InstagramRequestProtocol {
            case user(User)
            case recentMedia(RecentMediaParameter)
            case likedMedia(LikedMediaParameter)
            case search(SearchUserParameter)
        }
        
        
        //Parameters
        struct SearchUserParameter {
            let query: String
            var count: Int? = nil
        }
        
        struct LikedMediaParameter {
            let user: User
            var count: Int? = nil
            var maxId: String? = nil
        }
        
        struct RecentMediaParameter {
            let user: User
            let count: Int?
            let minId: String?
            let maxId: String?
            
            init(user: User, count: Int? = nil, minId: String? = nil, maxId: String? = nil) {
                self.user = user
                self.count = count
                self.minId = minId
                self.maxId = maxId
            }
        }
        
        enum User {
            case id(InstagramObjectId)
            case owner
            
            init(_ userId: InstagramObjectId? = nil) {
                if let userId = userId {
                    self = .id(userId)
                }
                else {
                    self = .owner
                }
            }
        }
    }
}

//MARK: RELATIONSHIP
extension Instagram {

    enum RelationshipEnpoint {
        
        
        //Requests
        enum Get: InstagramRequestProtocol {
            case follows
            case followedBy
            case requestedBy
            case relationship(userId: InstagramObjectId)
        }
        
        enum Post: InstagramRequestProtocol {
            case relationship(PostRelationshipParameter)
        }
        
        
        //Parameters
        struct PostRelationshipParameter {
            let userId: InstagramObjectId
            let action: Action
        }
        
        enum Action {
            case follow
            case unfollow
            case approve
            case ignore
        }
    }
}

//MARK: MEDIA
extension Instagram {
    
    enum MediaEndpoint {
        
        
        //Requests
        enum Get: InstagramRequestProtocol {
            case media(Media)
            case search(SearchMediaParameter)
        }
        
        
        /**
         @params A valid access token.
         - distance: Default is 1km (distance=1000), max distance is 5km.
         - longitude: Longitude of the center search coordinate. If used, lat is required.
         - latitude: Latitude of the center search coordinate. If used, lng is required.
         */
        struct SearchMediaParameter {
            let longitude: Double
            let latitude: Double
            var distance: Double? = nil
        }
        
        enum Media {
            case id(String)
            case shortcode(String)
        }
    }
}


//MARK: COMMENTS
extension Instagram {
    
    enum CommentsEndpoint {
        
        
        //Requests
        enum Get: InstagramRequestProtocol {
            case comment(mediaId: InstagramObjectId)
        }
        
        enum Post: InstagramRequestProtocol {
            case comment(PostCommentParameter)
        }
        
        enum Delete: InstagramRequestProtocol {
            case comment(DeleteCommentParameter)
        }
        
        
        //Parameters
        struct DeleteCommentParameter {
            let mediaId: InstagramObjectId
            let commentId: InstagramObjectId
        }
        
        struct PostCommentParameter {
            let mediaId: InstagramObjectId
            let text: String
            //TODO: Need to create typealis and return error if string is not supports
            /**
             The total length of the comment cannot exceed 300 characters.
             The comment cannot contain more than 4 hashtags.
             The comment cannot contain more than 1 URL.
             The comment cannot consist of all capital letters.
             */
        }
    }
}


//MARK: LIKES
extension Instagram {
    
    enum LikesEndpoint {
        
        
        //Requests
        enum Get: InstagramRequestProtocol {
            case likes(mediaId: InstagramObjectId)
        }
        
        enum Post: InstagramRequestProtocol {
            case like(mediaId: InstagramObjectId)
        }
        
        enum Delete: InstagramRequestProtocol {
            case like(DeleteLikeParameter)
        }
        
        
        //Parameters
        struct DeleteLikeParameter {
            let mediaId: InstagramObjectId
            let commentId: InstagramObjectId
        }
    }
}


//MARK: TAGS
extension Instagram {

    enum TagsEndpoint {
        

        //Requests
        enum Get: InstagramRequestProtocol {
            case tag(name: String)
            case recentMedia(RecentMediaParameter)
            case search(query: String)
        }
        
        
        //Parameters
        /**
         @params A valid access token.
         - maxId: Return media after this max_tag_id.
         - count: Count of tagged media to return.
         - minId: Return media before this min_tag_id.
         */
        struct RecentMediaParameter {
            let tagName: String
            var minId: String? = nil
            var maxId: String? = nil
            var count: Int? = nil
        }
    }
}


//MARK: LOCATIONS
extension Instagram {
 
    enum LocationsEndpoint {
        
        
        //Requests
        enum Get: InstagramRequestProtocol {
            case location(id: String)
            case recentMedia(RecentMediaParameter)
            case search(SearchMediaParameter)
        }
        
        
        //Params
        struct RecentMediaParameter {
            let locationId: InstagramObjectId
            var minId: String? = nil
            var maxId: String? = nil
        }
        
        struct SearchMediaParameter {
            var longitude: Double? = nil
            var latitude: Double? = nil
            var distance: Double? = nil
            var facebookPlacesId: InstagramObjectId? //If Used lng/lat is not required
        }
    }
}
