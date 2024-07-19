////
////  UserModel.swift
////  One Rep
////
////  Created by Dylan Ierugan on 6/3/24.
////
//
//import Foundation
//import RealmSwift
//
//class UserModel: Object, ObjectKeyIdentifiable  {
//    
//    @Persisted(primaryKey: true) var _id: ObjectId
//    @Persisted var ownerId: String
//    @Persisted var accountCreatedDate: Double = Date().timeIntervalSince1970
//    @Persisted var bodyweightEntries = RealmSwift.List<BodyweightEntry>()
//    
//}
