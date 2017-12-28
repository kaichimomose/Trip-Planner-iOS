//
//  ContainerForComments.swift
//  Product-Hunt-API
//
//  Created by Kaichi Momose on 2017/11/02.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import Foundation

struct Trip {
    let id: Int
    let tripName: String
//    let date: String
//    let waypoints: [String]
    let completed: Bool
    let waypoints: [String]
    
}

extension Trip: Decodable {
    
    enum Keys: String, CodingKey {
        case id
        case tripName = "trip_name"
        case completed
        case waypoints
//        case trips
    }
    
//    enum TripKeys: String, CodingKey {
//        case tripName = "trip_name"
////        case date
////        case waypoints
//        case completed
//    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let id = try container.decode(Int.self, forKey: .id)
//        let trips = try container.nestedContainer(keyedBy: TripKeys.self, forKey: .trips)
        let tripName = try container.decode(String.self, forKey: .tripName)
//        let date = try trips.decode(String.self, forKey: .date)
//        let waypoints = try trips.decode([String].self, forKey: .waypoints)
        let completed = try container.decode(Bool.self, forKey: .completed)
        let waypoints = try container.decode([String].self, forKey: .waypoints)
        self.init(id: id, tripName: tripName, completed: completed, waypoints: waypoints)//, date: date, waypoints: waypoints
    }
}
