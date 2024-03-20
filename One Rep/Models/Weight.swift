//
//  Weight.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/17/24.
//

import Foundation
import RealmSwift

class Weight: Object {
    @Persisted(primaryKey: true) var id: ObjectId
}
