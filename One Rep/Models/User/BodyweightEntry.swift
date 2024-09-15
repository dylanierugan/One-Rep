//
//  BodyweightEntry.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/9/24.
//

import Foundation

public struct BodyweightEntry: Codable {
    
    let id: String
    var bodyweight: Double
    var timeCreated: Date
    
    init(id: String,
         bodyweight: Double,
         timeCreated: Date) {
        self.id = id
        self.bodyweight = bodyweight
        self.timeCreated = timeCreated
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case bodyweight = "bodyweight"
        case timeCreated = "time_created"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.bodyweight = try container.decode(Double.self, forKey: .bodyweight)
        self.timeCreated = try container.decode(Date.self, forKey: .timeCreated)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.bodyweight, forKey: .bodyweight)
        try container.encode(self.timeCreated, forKey: .timeCreated)
    }
    
}
