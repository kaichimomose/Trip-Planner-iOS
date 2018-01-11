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

class User: NSObject, NSCoding {
    let id: Int
    let name: String
    let username: String
    let tripsCount: Int
//    let imageUrl: URL
    // MARK: - Singleton
    
    // 1
    private static var _current: User?
    // 2
    static var current: User {
        // 3
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        // 4
        return currentUser
    }
    
    // MARK: - Class Methods
    
    // 1
    static func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        // 2
        if writeToUserDefaults {
            // 3
            let data = NSKeyedArchiver.archivedData(withRootObject: user)
            
            // 4
            UserDefaults.standard.set(data, forKey: "currentUser")
            
        }
        
        _current = user
    }
    
    init(id: Int, name: String, username: String, tripsCount: Int) {
        self.id = id
        self.username = username
        self.tripsCount = tripsCount
        self.name = name
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
        let username = aDecoder.decodeObject(forKey: "username") as? String
            else { return nil }
        
        let tripsCount = aDecoder.decodeInteger(forKey: "tripsCount")
        
        self.init(id: id, name: name, username: username, tripsCount: tripsCount)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.username, forKey: "username")
        aCoder.encode(self.tripsCount, forKey: "tripsCount")
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let username = try container.decode(String.self, forKey: .username)
        let tripsCount = try container.decode(Int.self, forKey: .tripsCount)
        //        let imageUrl = try container.decode(URL.self, forKey: .thumbnail)
        self.init(id: id, name: name, username: username, tripsCount: tripsCount)//, imageUrl: imageUrl
    }
}

extension User: Decodable {
    enum Keys: String, CodingKey {
        case id
        case name
        case username
        case tripsCount = "trips_count"
//        case thumbnail = "image_url"
    }
}

