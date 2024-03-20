//
//  Movement.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/17/24.
//

import Foundation
import RealmSwift

class Movement: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var userId: ObjectId
    @Persisted var name: String
    @Persisted var weights: List<Weight>
    @Persisted var muscleGroup = MuscleGroup.Arms
    @Persisted var timeAdded: Double
    @Persisted var isPremium: Bool
    
    /// Backlink
    @Persisted(originProperty: "movements") var group: LinkingObjects<MovementViewModel>
    
    enum MuscleGroup: String, PersistableEnum {
        case Arms, Back, Chest, Core, Legs, Shoulders
    }

}
