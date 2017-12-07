//
//  Networking.swift
//  Product-Hunt-API
//
//  Created by Kaichi Momose on 2017/11/01.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import Foundation

class Networking {
    let session = URLSession.shared
    let baseURL = "https://api.producthunt.com/v1"
    
    func fetch(resource: Resource, completion: @escaping ([Decodable]) -> ()) {
        let fullUrl = baseURL + resource.path()
        var item = NSURLQueryItem()
        
        let components = NSURLComponents(string: fullUrl)
        for (key, value) in resource.urlParameters() {
            item = NSURLQueryItem(name: key, value: value)
        }
        
        components?.queryItems = [item as URLQueryItem]
        
        let url = components?.url
        print(url ?? "")
        
//        let url = URL(string: pramUrl!)!
        var request = URLRequest(url: url!)
        request.allHTTPHeaderFields = resource.header(token: "3c486e75957c3d8c0ee628b1cf0263782741826ad69cbf084e1d19317c1543cf")
        request.httpMethod = resource.httpMethod().rawValue
        
        session.dataTask(with: request) {(data, res, err) in
            if let data = data {
                switch resource {
                    case .posts:
                        let postsList = try? JSONDecoder().decode(PostsList.self, from: data)
                        guard let aPostsList = postsList?.posts else {return}
                        completion(aPostsList)
                    case .comments:
                        let commentsList = try? JSONDecoder().decode(CommentsList.self, from: data)
                        guard let aCommentsList = commentsList?.comments else {return}
                        completion(aCommentsList)
                    
                }
            }
        }.resume()
    }
}
