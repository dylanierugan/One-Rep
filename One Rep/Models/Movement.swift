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
    @Persisted var name: String
    @Persisted var logs: List<Log>
    @Persisted var routine: String
    @Persisted var muscleGroup: MuscleType
    @Persisted var timeAdded: Double
    @Persisted var isPremium: Bool
    
    /// Backlink
    @Persisted(originProperty: "movements") var group: LinkingObjects<MovementViewModel>
    //@Persisted(originProperty: "rotuines") var assignee: LinkingObjects<Routine>
    
    convenience init(name: String = "", muscleGroup: MuscleType = .Arms, logs: List<Log> = List<Log>(), routine: String, timeAdded: Double = 0, isPremium: Bool = false) {
        self.init()
        self.name = name
        self.muscleGroup = muscleGroup
        self.logs = logs
        self.routine = routine
        self.timeAdded = timeAdded
        self.isPremium = isPremium
    }
}
