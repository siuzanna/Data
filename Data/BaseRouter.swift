//
//  BaseRouter.swift
//  Test
//
//  Created by Фатихсултан Жакшылыков on 3/9/21.
//

import Foundation

struct HttpHeader {
    var field: String
    var value: String
}

protocol BaseRouter {
    var path: String { get }
    var queryParameter: [URLQueryItem]? { get }
    
    var method: String { get }
    var httpBody: Data? { get }
    var httpHeader: [HttpHeader]? { get }
}

extension BaseRouter {
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "run.mocky.io"
    }
    
    var path: String {
        return "v3"
    }
    
    var queryParameter: [URLQueryItem]? {
        return [URLQueryItem( name: "", value: "1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c")]
    }
    
    func getURLRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryParameter
        
        guard let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else {
            fatalError()
        }
        var request = URLRequest(url: url)
        for i in httpHeader ?? [] {
            request.setValue(i.value, forHTTPHeaderField: i.field)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = method
        return request
    }
}

