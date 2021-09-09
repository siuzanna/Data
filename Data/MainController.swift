
import Foundation

enum MainController: BaseRouter {
    case getAllPosts
    case getById(id: Int)
    case addPost(body: Data)
    case getByPostId(id: String)
    
    var path: String {
        switch self {
        case .getAllPosts:
            return "/posts"
        case .getById(let id):
            return "/posts/\(id)"
        case .addPost:
            return "/posts"
        case .getByPostId:
            return "/posts"
        }
    }
    
    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getAllPosts:
            return nil
        case .getById:
            return nil
        case .addPost:
            return nil
        case .getByPostId(let id):
            return [
//                URLQueryItem(name: "postId", value: id),
                .init(name: "postId", value: id)
            ]
        }
    }
    
    var method: String {
        switch self {
        case .getAllPosts:
            return HttpMethods.GET.rawValue
        case .getById:
            return HttpMethods.GET.rawValue
        case .addPost:
            return HttpMethods.POST.rawValue
        case .getByPostId:
            return HttpMethods.GET.rawValue
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .getAllPosts:
            return nil
        case .getById:
            return nil
        case .addPost(let body):
            return body
        case .getByPostId:
            return nil
        }
    }
    
    var httpHeader: [HttpHeader]? {
        switch self {
        case .getAllPosts:
            return nil
        case .getById:
            return nil
        case .addPost:
            return nil
        case .getByPostId:
            return nil
        }
    }
}

enum HttpMethods: String {
    case GET
    case POST
    case PUT
    case DELETE
}
