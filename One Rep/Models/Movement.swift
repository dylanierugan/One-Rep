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
    @Persisted var logs: List<Log>
    @Persisted var muscleGroup: String
    @Persisted var timeAdded: Double
    @Persisted var isPremium: Bool
    
    /// Backlink
    @Persisted(originProperty: "movements") var group: LinkingObjects<MovementViewModel>
    
    convenience init(name: String = "", muscleGroup: String = "", logs: List<Log> = List<Log>(), timeAdded: Double = 0, isPremium: Bool = false) {
        self.init()
        self.name = name
        self.muscleGroup = muscleGroup
        self.logs = logs
        self.timeAdded = timeAdded
        self.isPremium = isPremium
    }

}
