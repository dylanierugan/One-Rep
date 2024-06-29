////
////  BodyweightEntry.swift
////  One Rep
////
////  Created by Dylan Ierugan on 6/9/24.
////
//
//import Foundation
//import RealmSwift
//
//class BodyweightEntry: Object, ObjectKeyIdentifiable  {
//    
//    @Persisted(primaryKey: true) var _id: ObjectId
//    @Persisted var bodyweight: Double
//    @Persisted var timeAdded: Double
//    
//    /// Backlink
//    // @Persisted(originProperty: "bodyweightEntries") var userModel: LinkingObjects<UserModel>
//    
//    convenience init(bodyweight: Double = 0, timeAdded: Double = 0) {
//        self.init()
//        self.bodyweight = bodyweight
//        self.timeAdded = timeAdded
//    }
//    
//}
