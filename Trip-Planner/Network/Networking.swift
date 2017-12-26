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
    let baseURL = "https://trip-planner-km.herokuapp.com"
    
    func fetch(resource: Resource, completion: @escaping (Decodable) -> ()) {
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
        request.allHTTPHeaderFields = resource.header()
        request.httpMethod = resource.httpMethod().rawValue
        request.httpBody = resource.body()
        
        session.dataTask(with: request) {(data, res, err) in
            if let data = data {
                switch resource {
                    case .login, .signUp, .editProfile, .deleteAccount:
                        let user = try? JSONDecoder().decode(User.self, from: data)
                        guard let aUser = user else {return}
                        completion(aUser)
                    case .friendsTrip, .postTrip, .deleteTrip, .editTrip, .findFriend:
                        let tripsList = try? JSONDecoder().decode(TripsList.self, from: data)
                        guard let aTripsList = tripsList?.trips else {return}
                        completion(aTripsList)
                    
                }
            }
        }.resume()
    }
}
