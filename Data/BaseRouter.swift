////
////  NetworkComponents.swift
////  Data
////
////  Created by siuzanna on 6/9/21.
////
//
//import Foundation
//
//struct HttpHeader {
//    var field: String
//    var value: String
//}
//
//protocol BaseRouter {
//    var path: String {get}
//    var method: String {get}
//    var quereParameter: [URLQueryItem]? {get}
//    var httpBody: Data? {get}
//    var httpHeader: [HttpHeader]? {get}
//}
//
//extension BaseRouter{
//    
//    var host: String {
//        return "run.mocky.io"
//    }
//    var scheme: String {
//        return "http"
//    }
//    func createURLRequest() -> URLRequest {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = scheme
//        urlComponents.host = host
//        urlComponents.path = path
//        urlComponents.queryItems = quereParameter
//        guard let url = urlComponents.url else {
//            fatalError(URLError(.unsupportedURL).localizedDescription)
//        }
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = method
//        urlRequest.httpBody = httpBody
//        httpHeader?.forEach({ (header) in
//            urlRequest.setValue(header.value, forHTTPHeaderField: header.field)
//        })
//        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
////        let userDefaultsService = UserDefaultsService()
////        if let token =
//        return urlRequest
//    }
//}
