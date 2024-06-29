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
    var isBodyWeight: Bool
    var timeAdded: Double
    var unit: UnitSelection
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case movementId
        case reps
        case weight
        case isBodyWeight
        case timeAdded
        case unit
    }
}
