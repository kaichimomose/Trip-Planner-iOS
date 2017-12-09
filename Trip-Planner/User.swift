//
//  Container.swift
//  Product-Hunt-API
//
//  Created by Kaichi Momose on 2017/11/01.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import Foundation

//struct UsersList: Decodable {
//    let users: [User]
//}

struct User {
    let id: Int
    let name: String
    let username: String
    let tripsCount: Int
    let imageUrl: URL
}

extension User: Decodable {
    enum Keys: String, CodingKey {
        case id
        case name
        case username
        case tripsCount = "trips_count"
        case thumbnail = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let username = try container.decode(String.self, forKey: .username)
        let tripsCount = try container.decode(Int.self, forKey: .tripsCount)
        let imageUrl = try container.decode(URL.self, forKey: .thumbnail)
        self.init(id: id, name: name, username: username, tripsCount: tripsCount, imageUrl: imageUrl)
    }
}
