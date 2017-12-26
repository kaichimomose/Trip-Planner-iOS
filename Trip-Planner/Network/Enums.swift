//
//  Enums.swift
//  Product-Hunt-API
//
//  Created by Kaichi Momose on 2017/11/01.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Resource {
    case signUp(email: String, password: String)
    case login(email: String, password: String)
    case editProfile
    case deleteAccount
    
    case postTrip
    case editTrip
    case deleteTrip
    case friendsTrip
    case findFriend(username: String)
    
    func httpMethod() -> HttpMethod {
        switch self {
        case .login, .friendsTrip, .findFriend:
            return .get
        case .signUp, .postTrip:
            return .post
        case .editTrip, .editProfile:
            return .put
        case .deleteTrip, .deleteAccount:
            return .delete
        }
    }
    
    func header() -> [String: String] {
        switch self {
        case let .login(email, password):
            let token = BasicAuth.generateBasicAuthHeader(username: email, password: password)
            
            return ["Authorization": "\(token)",
                    "Content-Type": "application/json"
            ]
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    func path() -> String {
        switch self {
        case .login, .signUp, .editProfile, .deleteAccount:
            return "/users"
        case .friendsTrip, .postTrip, .deleteTrip, .editTrip, .findFriend:
            return "/trip"
        }
    }
    
    func urlParameters() -> [String: String] {
        switch self {
        case .findFriend(let username):
            return ["username": username]
        default:
                return [:]
        }
    }
    
    func body() -> Data? {
        switch self {
        case let .signUp(email, password)://, .postTrip
            let json = ["username": email, "password": password, "name": "","trip_count": 0, "id": 0] as [String: Any]
            let data = try? JSONSerialization.data(withJSONObject: json, options: [])
            return data
        default:
            return nil
        }
    }
}
