//
//  ContainerForComments.swift
//  Product-Hunt-API
//
//  Created by Kaichi Momose on 2017/11/02.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import Foundation

struct CommentsList: Decodable {
    let comments: [Comment]
}

struct Comment {
    let body: String
    let name: String
    let username: String
    let size: URL
}

extension Comment: Decodable {
    enum Keys: String, CodingKey {
        case body
        case user
    }
    
    enum UserKeys: String, CodingKey {
        case username
        case name
        case imageUrl = "image_url"
    }
    
    enum ImageUrlKeys: String, CodingKey {
        case size = "48px"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let body = try container.decode(String.self, forKey: .body)
        let user = try container.nestedContainer(keyedBy: UserKeys.self, forKey: .user)
        let name = try user.decode(String.self, forKey: .name)
        let username = try user.decode(String.self, forKey: .username)
        let imageUrl = try user.nestedContainer(keyedBy: ImageUrlKeys.self, forKey: .imageUrl)
        let size = try imageUrl.decode(URL.self, forKey: .size)
        self.init(body: body, name: name, username: username, size: size)
    }
}
