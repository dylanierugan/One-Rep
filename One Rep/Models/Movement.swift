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
    @Persisted var muscleGroup: String
    @Persisted var timeAdded: Double
    @Persisted var isPremium: Bool
    
    /// Backlink
    @Persisted(originProperty: "movements") var group: LinkingObjects<MovementViewModel>
    
    convenience init(name: String = "", muscleGroup: String = "", weights: List<Weight> = List<Weight>(), timeAdded: Double = 0, isPremium: Bool = false) {
        self.init()
        self.name = name
        self.muscleGroup = muscleGroup
        self.weights = weights
        self.timeAdded = timeAdded
        self.isPremium = isPremium
    }

}
