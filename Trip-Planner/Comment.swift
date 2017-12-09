//
//  ContainerForComments.swift
//  Product-Hunt-API
//
//  Created by Kaichi Momose on 2017/11/02.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import Foundation

struct TripsList: Decodable {
    let trips: [Trip]
}

struct Trip {
    let id: Int
    let username: String
    let tripName: String
    let date: String
    let waypoints: [String]
    let completed: Bool
}

extension Trip: Decodable {
    
    enum Keys: String, CodingKey {
        case id
        case username
        case trips
    }
    
    enum TripKeys: String, CodingKey {
        case tripName = "trip_name"
        case date
        case waypoints
        case completed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let username = try container.decode(String.self, forKey: .username)
        let trips = try container.nestedContainer(keyedBy: TripKeys.self, forKey: .trips)
        let tripName = try trips.decode(String.self, forKey: .tripName)
        let date = try trips.decode(String.self, forKey: .date)
        let waypoints = try trips.decode([String].self, forKey: .waypoints)
        let completed = try trips.decode(Bool.self, forKey: .completed)
        self.init(id: id, username: username, tripName: tripName, date: date, waypoints: waypoints, completed: completed)
    }
}
