//
//  Movement.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/17/24.
//

import Foundation
import Firebase

public struct Movement: Identifiable, Codable, Hashable, Equatable {
        
    public let id: String
    var name: String
    var muscleGroup: MuscleGroup
    var movementType: MovementType
    let timeCreated: Date
    let isPremium: Bool
    var mutatingValue: Double
    var logs: [Log]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case muscleGroup = "muscle_group"
        case movementType = "movement_type"
        case timeCreated = "time_created"
        case isPremium = "is_premium"
        case mutatingValue = "mutating_value"
        case logs
    }
    
    init(id: String, name: String, muscleGroup: MuscleGroup, movementType: MovementType, timeCreated: Date, isPremium: Bool, mutatingValue: Double) {
        self.id = id
        self.name = name
        self.muscleGroup = muscleGroup
        self.movementType = movementType
        self.timeCreated = timeCreated
        self.isPremium = isPremium
        self.mutatingValue = mutatingValue
        self.logs = []
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.muscleGroup, forKey: .muscleGroup)
        try container.encode(self.movementType, forKey: .movementType)
        try container.encode(self.timeCreated, forKey: .timeCreated)
        try container.encode(self.isPremium, forKey: .isPremium)
        try container.encode(self.mutatingValue, forKey: .mutatingValue)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.muscleGroup = try container.decode(MuscleGroup.self, forKey: .muscleGroup)
        self.movementType = try container.decode(MovementType.self, forKey: .movementType)
        self.timeCreated = try container.decode(Date.self, forKey: .timeCreated)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
        self.mutatingValue = try container.decode(Double.self, forKey: .mutatingValue)
        self.logs = []
    }
    
}
