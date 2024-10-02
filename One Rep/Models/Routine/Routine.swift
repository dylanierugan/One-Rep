
//  Routine.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/10/24.
//

import Foundation

public struct Routine: Identifiable, Codable, Hashable, Equatable {
    
    public let id: String
    var name: String
    var icon: String
    var movementIDs: [String]
    var timeCreated: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case icon = "icon"
        case movementIDs = "movement_ids"
        case timeCreated = "time_created"
    }
    
    init(id: String, name: String, icon: String, movementIDs: [String], timeCreated: Date) {
        self.id = id
        self.name = name
        self.icon = icon
        self.movementIDs = movementIDs
        self.timeCreated = timeCreated
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.icon, forKey: .icon)
        try container.encode(self.movementIDs, forKey: .movementIDs)
        try container.encode(self.timeCreated, forKey: .timeCreated)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.icon = try container.decode(String.self, forKey: .icon)
        self.movementIDs = try container.decode([String].self, forKey: .movementIDs)
        self.timeCreated = try container.decode(Date.self, forKey: .timeCreated)
    }
}
