//
//  JSONModel.swift
//  Test
//
//  Created by Фатихсултан Жакшылыков on 8/9/21.
//

import Foundation

struct JSONModel: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    
    init(userId: Int?, id: Int?, title: String?, body: String?) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
    
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        userId = try? container.decodeIfPresent(Int.self, forKey: .userId)
        id = try? container.decodeIfPresent(Int.self, forKey: .id)
        title = try? container.decodeIfPresent(String.self, forKey: .title)
        body = try? container.decodeIfPresent(String.self, forKey: .body)
    }
    
    func encode(to encoder: Encoder) throws {
        var coder = encoder.container(keyedBy: CodingKeys.self)
        
        try? coder.encode(userId, forKey: .userId)
        try? coder.encode(id, forKey: .id)
        try? coder.encode(title, forKey: .title)
        try? coder.encode(body, forKey: .body)
    }
}
