//
//  Log.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/17/24.
//

import Foundation
import Firebase

public struct Log: Identifiable, Codable, Hashable, Equatable  {
    
    public let id: String
    let userId: String
    let movementId: String
    var reps: Int
    var weight: Double
    var bodyweight: Double
    var isBodyWeight: Bool
    var timeAdded: Date
    var unit: UnitSelection
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case movementId = "movement_id"
        case reps = "reps"
        case weight = "weight"
        case bodyweight = "bodyweight"
        case isBodyWeight = "is_body_weight"
        case timeAdded = "time_added"
        case unit = "unit"
    }
    
    init(id: String = "", userId: String = "", movementId: String = "", reps: Int = 0, weight: Double = 0.0, bodyweight: Double = 0.0, isBodyWeight: Bool = false, timeAdded: Date = Date(), unit: UnitSelection = .lbs, index: Int = 0) {
        self.id = id
        self.userId = userId
        self.movementId = movementId
        self.reps = reps
        self.weight = weight
        self.bodyweight = bodyweight
        self.isBodyWeight = isBodyWeight
        self.timeAdded = timeAdded
        self.unit = unit
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.movementId, forKey: .movementId)
        try container.encode(self.reps, forKey: .reps)
        try container.encode(self.weight, forKey: .weight)
        try container.encode(self.bodyweight, forKey: .bodyweight)
        try container.encode(self.isBodyWeight, forKey: .isBodyWeight)
        try container.encode(self.timeAdded, forKey: .timeAdded)
        try container.encode(self.unit, forKey: .unit)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.movementId = try container.decode(String.self, forKey: .movementId)
        self.reps = try container.decode(Int.self, forKey: .reps)
        self.weight = try container.decode(Double.self, forKey: .weight)
        self.bodyweight = try container.decode(Double.self, forKey: .bodyweight)
        self.isBodyWeight = try container.decode(Bool.self, forKey: .isBodyWeight)
        self.timeAdded = try container.decode(Date.self, forKey: .timeAdded)
        self.unit = try container.decode(UnitSelection.self, forKey: .unit)
    }
}
