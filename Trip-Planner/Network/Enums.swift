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
    case patch = "PATCH"
    case delete = "DELETE"
}

enum Resource {
    case signUp(email: String, password: String)
    case login(email: String, password: String)
    case editProfile
    case deleteAccount
    
    case myTrip(id: Int)
    case postTrip(id: Int, tripName: String, completed: Bool, waypoints: [String])
    case editTrip(id: Int, oldTrip: String, newTrip: String, completed: Bool, waypoints: [String])
    case deleteTrip(id: Int, tripName: String)
    case friendsTrip
    case findFriend(username: String)
    
    func httpMethod() -> HttpMethod {
        switch self {
        case .login, .myTrip, .friendsTrip, .findFriend:
            return .get
        case .signUp, .postTrip:
            return .post
        case .editTrip, .editProfile:
            return .patch
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
        case .myTrip, .friendsTrip, .postTrip, .deleteTrip, .editTrip, .findFriend:
            return "/trip"
        }
    }
    
    func urlParameters() -> [String: String] {
        switch self {
        case .findFriend(let username):
            return ["username": username]
        case .myTrip(let id):
            return ["id": String(id)]
        default:
            return [:]
        }
    }
    
    func body() -> Data? {
        switch self {
        case let .signUp(email, password):
            let json = ["username": email, "password": password, "name": "", "trips_count": 0, "id": 0] as [String: Any]
            let data = try? JSONSerialization.data(withJSONObject: json, options: [])
            return data
        case let .postTrip(id, tripName, completed, waypoints):
            let json = ["id": id, "trip_name": tripName, "completed": completed, "waypoints": waypoints] as [String: Any]
            let data = try? JSONSerialization.data(withJSONObject: json, options: [])
            return data
        case let .editTrip(id, oldTrip, newTrip, completed, waypoints):
            let json = ["id": id, "old_trip": oldTrip, "new_trip": newTrip, "completed": completed, "waypoints": waypoints] as [String: Any]
            let data = try? JSONSerialization.data(withJSONObject: json, options: [])
            return data
        case let .deleteTrip(id, tripName):
            let json = ["id": id, "trip_name": tripName] as [String: Any]
            let data = try? JSONSerialization.data(withJSONObject: json, options: [])
            return data
        default:
            return nil
        }
    }
}
