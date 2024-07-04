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
    let userId: String
    var name: String
    var muscleGroup: MuscleGroup
    var movementType: MovementType
    let timeAdded: Double
    let isPremium: Bool
    let mutatingValue: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case name
        case muscleGroup
        case movementType
        case timeAdded
        case isPremium
        case mutatingValue
    }
}
