//
//  BodyweightEntry.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/9/24.
//

import Foundation

public struct BodyweightEntry: Identifiable, Codable, Hashable, Equatable {
    
    public let id: String
    let userId: String
    var bodyweight: Double
    var timeAdded: Double
    
}
