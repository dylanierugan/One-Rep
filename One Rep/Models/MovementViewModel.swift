//
//  Movements.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import Foundation
import RealmSwift

class MovementViewModel: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var ownerId: String
    @Persisted var movements = RealmSwift.List<Movement>()
    
}
