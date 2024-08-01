
//  Routine.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/10/24.
//

import Foundation

public struct Routine: Identifiable, Codable, Hashable, Equatable {
    public let id: String
    let userId: String
    var name: String
    var icon: String
    var movementIDs: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case name
        case icon
        case movementIDs
    }
}
