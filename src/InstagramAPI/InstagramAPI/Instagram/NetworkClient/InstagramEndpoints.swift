//
//  InstagramEndpoints.swift
//  InstagramAPI
//
//  Created by Denis on 16.01.17.
//  Copyright © 2017 ConceptOffice. All rights reserved.
//

import UIKit

struct InstagramRequest<Endpoint: InstagramEndpointProtocol> {
    
    private(set) var endpoint: Endpoint
    init(_ endpoint: Endpoint) {
        self.endpoint = endpoint
    }
}

enum UserId {
    case id(String)
    case owner
    
    init(_ userId: String?) {
        if let userId = userId {
            self = .id(userId)
        }
        else {
            self = .owner
        }
    }
}

enum UserRequest {

    case get(Get)
    
    enum Get {
        case user(UserId)
        case recentMedia(id: UserId)
        case likedMedia
        case search(name: String)
    }
}

enum RealtionshipEndpoint {
    
    enum Get {
        case follows
        case followedBy
        case requestedBy
        case relationship(id: String)
    }
    
    enum Post {
        case relationship(id: String)
    }
}

enum MediaId {
    case id(String)
    case shortcode(String)
}

enum MediaEndpoint {
    enum Get {
        case media(MediaId)
        case search(area: String)
    }
}

enum CommentsEndpoint {
    case post(mediaId: String)
    case get(mediaId: String)
    case delete(mediaId: String, commentId: String)
    
}
enum LikesEndpoint {
    case post(mediaId: String)
    case get(mediaId: String)
    case delete(mediaId: String)
}
enum TagsEndpoint {
    case get(name: String)
    case eecentMedia(tag: String)
    case search(name: String)
}
enum LocationsEndpoint{
    case location(id: String)
    case recentMedia(id: String)
    case search(coordinate: (Double, Double))
}
