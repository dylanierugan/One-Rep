//
//  Log.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/17/24.
//

import Foundation
import Firebase

public struct Log: Codable {
    
    let id: String
    let userId: String
    let movementId: String
    var reps: Int
    var weight: Double
    var bodyweight: Double
    var isBodyWeight: Bool
    var timeAdded: Double
    var unit: UnitSelection
    
    init(id: String = "", userId: String = "", movementId: String = "", reps: Int = 0, weight: Double = 0.0, bodyweight: Double = 0.0, isBodyWeight: Bool = false, timeAdded: Double = 0.0, unit: UnitSelection = .lbs, index: Int = 0) {
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case movementId
        case reps
        case weight
        case bodyweight
        case isBodyWeight
        case timeAdded
        case unit
    }
}
