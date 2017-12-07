//
//  Container.swift
//  Product-Hunt-API
//
//  Created by Kaichi Momose on 2017/11/01.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import Foundation

struct PostsList: Decodable {
    let posts: [Post]
}

struct Post {
    let id: Int
    let name: String
    let tagline: String
    let votesCount: Int
    let imageUrl: URL
}

extension Post: Decodable {
    enum Keys: String, CodingKey {
        case id
        case name
        case tagline
        case votesCount = "votes_count"
        case thumbnail
    }
    
    enum ThumbnailKeys: String, CodingKey {
        case imageUrl = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let tagline = try container.decode(String.self, forKey: .tagline)
        let votesCount = try container.decode(Int.self, forKey: .votesCount)
        let thumbnail = try container.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .thumbnail)
        let imageUrl = try thumbnail.decode(URL.self, forKey: .imageUrl)
        self.init(id: id, name: name, tagline: tagline, votesCount: votesCount, imageUrl: imageUrl)
    }
}
