//
//  Weight.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/17/24.
//

import Foundation
import RealmSwift

class Log: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var reps: Int
    @Persisted var weight: Double
    @Persisted var isBodyWeight: Bool
    @Persisted var repType: String
    
    convenience init(reps: Int = 0, weight: Double = 0, isBodyWeight: Bool, repType: String) {
        self.init()
        self.reps = reps
        self.weight = weight
        self.isBodyWeight = isBodyWeight
        self.repType = repType
    }
}