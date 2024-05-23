//
//  Routine.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/10/24.
//

import Foundation
import RealmSwift

class Routine: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var icon: String
    @Persisted var timeAdded: Double
    @Persisted var movements: List<Movement>
    
    /// Backlink
    @Persisted(originProperty: "routines") var group: LinkingObjects<RoutineViewModel>
    
    convenience init(name: String = "", icon: String = "", timeAdded: Double = 0, movements: List<Movement> = List<Movement>()) {
        self.init()
        self.name = name
        self.icon = icon
        self.timeAdded = timeAdded
        self.movements = movements
    }
}
