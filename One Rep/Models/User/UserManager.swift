//
//  UserManager.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/13/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    
    // MARK: - Properties
    
    private let userCollection: CollectionReference = Firestore.firestore().collection(FirebaseCollection.UserCollection.rawValue)
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
//    private let encoder: Firestore.Encoder = {
//        let encoder = Firestore.Encoder()
//        return encoder
//    }()
//
//    private let decoder: Firestore.Decoder = {
//        let decoder = Firestore.Decoder()
//        return decoder
//    }()
    
    // MARK: - Public Functions
    
    func createNewUser(user: UserModel) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func getUser(userId: String) async throws -> UserModel {
        return try await userDocument(userId: userId).getDocument(as: UserModel.self)
    }
    
    func updateUserPremiumStatus(userId: String, isPremium: Bool) async throws {
        let data: [String:Any] = [
            UserModel.CodingKeys.isPremium.rawValue : isPremium,
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    // MARK: - Bodyweight Functions
    
    private func bodyweightCollection(userId: String) -> CollectionReference {
        userDocument(userId: userId).collection(FirebaseCollection.BodyweightCollection.rawValue)
    }
    
    private func userBodyweightDocument(userId: String, bodyweightEntryId: String) -> DocumentReference {
        bodyweightCollection(userId: userId).document(bodyweightEntryId)
    }
    
    func getBodyweightEntries(userId: String) async throws -> [BodyweightEntry] {
        let snapshot = try await bodyweightCollection(userId: userId).getDocuments(as: BodyweightEntry.self)
        var bodyweightEntries: [BodyweightEntry] = []
        for document in snapshot {
            bodyweightEntries.append(document)
        }
        return bodyweightEntries
    }
    
    func addUserBodyweight(userId: String, bodyweight: Double) async throws -> [BodyweightEntry] {
        let document = bodyweightCollection(userId: userId).document()
        let documentId = document.documentID
        let data: [String:Any] = [
            BodyweightEntry.CodingKeys.id.rawValue : documentId,
            BodyweightEntry.CodingKeys.bodyweight.rawValue : bodyweight,
            BodyweightEntry.CodingKeys.timeCreated.rawValue : Date()
        ]
        try await document.setData(data, merge: false)
        return try await getBodyweightEntries(userId: userId)
    }
    
    func removeBodyweight(userId: String, bodyweightEntryId: String) async throws -> [BodyweightEntry] {
        try await userBodyweightDocument(userId: userId, bodyweightEntryId: bodyweightEntryId).delete()
        return try await getBodyweightEntries(userId: userId)
    }
    
    func deleteAllBodyweightEntries(userId: String) async throws {
        let bodyweightEntries = try await getBodyweightEntries(userId: userId)
        for entry in bodyweightEntries {
            let _ = try await removeBodyweight(userId: userId, bodyweightEntryId: entry.id)
        }
    }
    
}
