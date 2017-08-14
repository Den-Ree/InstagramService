////: Playground - noun: a place where people can play
//
import UIKit

struct InstagramRequest<Endpoint> {

    private(set) var endpoint: Endpoint
    init(_ endpoint: Endpoint) {
        self.endpoint = endpoint
    }
}

enum UserEndpoints {
    enum Get {
        case user(id: String)
        case recentMedia(id: String)
        case likedMedia
        case search(name: String)
    }

    enum Post {
        case user
    }
}

let endpoint = UserEndpoints.Post.user
let request = InstagramRequest(endpoint)

//
//public class User: NSObject {}
//public class Media: NSObject {}
//public class Comment: NSObject {}
//
//public typealias InstagramResponseBlock<Response> = ()->(response: Response, error: NSError?)
//
//public typealias InstagramEndpointPath = String
//extension InstagramEndpointPath {
//    static let noPath = "InstagramEndpointPathNoPath"
//}
//
//protocol InstagramEndointProtocol {
//    var path: InstagramEndpointPath {get}
//}
//
//enum InstagramRequest<Endpoint> {
//   
//}
//
//extension InstagramRequest where Endpoint == RelationshipsEndpoint2, Params == UserParams {
//    
//}
//
//final class Instagram {
//    
//
//    struct UserParams {
//        var id: String
//    }
//
//    enum UserEndpoint {
//        case user(request: InstagramRequest<UserParams>)
//        case recentMedia(id: UserId)
//        case likedMedia
//        case search(name: String)
//        
//        enum UserId {
//            case id(String)
//            case owner
//        }
//    }
//    
//    enum RelationshipsEndpoint {
//        case follows
//        case followedBy
//        case requestedBy
//        case get(id: String)
//        case post(id: String)
//    }
//    
//    enum RelationshipsEndpoint2 {
//        enum Get {
//            case follows
//            case followedBy
//            case requestedBy
//            case relationship(id: String)
//        }
//        enum Post {
//            case relationship(id: String)
//        }
//    }
////    let endpoint = Instagram.RelationshipsEndpoint2.Post.relationship(id: "")
//    enum MediaEndpoint {
//        case get(id: MediaId, maxId: String)
//        case search(area: String)
//        
//        enum MediaId {
//            case id(String)
//            case shortcode(String)
//        }
//    }
//    
//    enum CommentsEndpoint {
//        case post(mediaId: String)
//        case get(mediaId: String)
//        case delete(mediaId: String, commentId: String)
//        
//    }
//    enum LikesEndpoint {
//        case post(mediaId: String)
//        case get(mediaId: String)
//        case delete(mediaId: String)
//    }
//    enum TagsEndpoint {
//        case get(name: String)
//        case eecentMedia(tag: String)
//        case search(name: String)
//    }
//    enum LocationsEndpoint{
//        case location(id: String)
//        case recentMedia(id: String)
//        case search(coordinate: (Double, Double))
//    }
//}
////
////class InstagraMan {
////    
////    func sendRequest<Endpoint>(for endpoint: Endpoint) {
////        if let endpoint = endpoint as? Instagram.MediaEndpoint {
////            
////        }
////    }
////}
//
//extension Instagram.LikesEndpoint where  {
//    
//}
//
//let endpoint = Instagram.CommentsEndpoint.get(mediaId: "commentId")
//let userEndpoint = Instagram.UserEndpoint.user(request: InstagramRequest.get(params: Instagram.UserParams(id: "")))
//let mediaEndpoint = Instagram.MediaEndpoint.get(id: .shortcode("vdvfdsv"), maxId: "vdfvdfv")
//
////let service = InstagramService()
//service.sendRequest(for: mediaEndpoint)
//
//
////extension Instagram.Endpoint: InstagramEndointProtocol {
////    var path: InstagramEndpointPath {
//////        switch self {
//////        case .users(let endPoint):
//////            return endPoint.path
//////        default:
//////            return InstagramEndpointPath.noPath
//////        }
////    }
////}
//
//
////extension UserEndpoint: InstagramEndointProtocol {
////    var path: String {
////        switch self {
//////        case .users(let userId):
//////            switch userId {
//////                case
//////            }
//////        }
////    }
////}
////
//final class InstagramNetworkService {
//    
//    func sendRequest<Response>(for endpoint: Instagram.Endpoint, completion: InstagramResponseBlock<Response>) {
//        
//    }
//}
//
///**
// /developer/endpoints/users/" class="active">Users</a>
// </li>
// <li >
// <a href="/developer/endpoints/relationships/" >Relationships</a>
// </li>
// <li >
// <a href="/developer/endpoints/media/" >Media</a>
// </li>
// <li >
// <a href="/developer/endpoints/comments/" >Comments</a>
// </li>
// <li >
// <a href="/developer/endpoints/likes/" >Likes</a>
// </li>
// <li >
// <a href="/developer/endpoints/tags/" >Tags</a>
// </li>
// <li >
// <a href="/developer/endpoints/locations/" >Locations</a>
// */
//
//let result = InstagramEndpoints.users(.user(id: UserId.owner))
//var request = InstagramRequest<Any>(result)
//
//request.response { (Any) -> () in
//    
//}
//
//public protocol InstagramManagerProtocol: class {
//    
//    var authorizedUsers: [User] {get}
//    var selectedUser: User {get}
//    
//    func authorize(with webView: UIWebView, completion: InstagramBaseResponseBlock?)
//    func logout(userId: String, completion: InstagramBaseResponseBlock?)
//
//    //USER
//    func request<T>(_ request: T, completion: InstagramBaseResponseBlock)
//}
//
//final class InstagramManager: NSObject {
//    
//}
//
//typealias InstagramEndpointPath = String
//
////let request = Instagram.manager.request.get.user()
////request.response {
////}
//
//
////Idea with endpoints
//enum Endpoint: String {
//    case apiTest = "api.test"
//    case authRevoke = "auth.revoke"
//    case authTest = "auth.test"
//}
//
//
////enum Test {
////    case api(Int)
////}
////
////var test = Test.api(5)
//
//enum AllEndpoint {
//    case User(UserEndpoint)
//    case Media
//}
//
//
//
//let userEndpoint = UserEndpoint.user(id: UserId.id("1234d"))
////let result = AllEndpoint.User(userEndpoint)
//
//class Request {
//    
//}
//
////let request = UserEndpoint.Media(id: "result")
//
//
//typealias TestHadler = ()->()
//class API: NSObject {
//    public func authorize(with webView: UIWebView, delegate: NSObjectProtocol?, completionHandler: @escaping TestHadler) {
//    }
//    
//    static func send(_ request: UserEndpoint, completion: TestHadler) {
//        
//    }
//    
//    static func loadMore() {
//        
//    }
//    
//    static func refresh() {
//        
//    }
//}
//
////API.send(UserEndpoint.Media(id: "")) {
////    
////}
//
//enum Result<T, E: Error>
//{
//    case success(T)
//    case failure(E)
//}
//
////Instagram.manager.request(Request).completion() //Request, PaginationRequest
////InstagramManager.shared.get.users.media.recent(_ id: nil, parameters: parameters) {}
//
//
//enum InstagramNew {
//    enum Users {
//        case user(String?)
//        case mediaRecent(String?)
//        case mediaLiked
//        case search
//        
//        public func get(_: Parameters.Users) {}
//        public func post(_: Parameters.Users) {
//            //Alamofire send request with URLpath = self, method = .post, parameters = parameters
//        }
//    }
//}
//
//struct Parameters {
//    struct Users {
//        var accessToken: String?
//        var minID: String?
//        var maxID: String?
//        var count: String?
//        var maxLikeID: String?
//        var q: String?
//        
//        init(
//            accessToken: String? = nil,
//            minID: String? = nil,
//            maxID: String? = nil,
//            count: String? = nil,
//            maxLikeID: String? = nil,
//            q: String? = nil
//            ) {
//            self.accessToken = accessToken
//            self.minID = minID
//            self.maxID = maxID
//            self.maxLikeID = maxLikeID
//            self.q = q
//        }
//    }
//}
//
//extension Instagram.Users: CustomStringConvertible {
//    var description: String {
//        switch self {
//        case .user(let id):
//            let value = id ?? "self"
//            return "users/\(value)"
//        case .mediaRecent(let id):
//            let value = id ?? "self"
//            return "users/\(value)/media/recent"
//        case .mediaLiked:
//            return "users/self/media/liked"
//        case .search:
//            return "users/search"
//        }
//    }
//}
//
//
//let parameters = Parameters.Users(minID: "0", maxID: "10", count: "5")
//InstagramNew.Users.mediaRecent("123123").post(parameters)
//
