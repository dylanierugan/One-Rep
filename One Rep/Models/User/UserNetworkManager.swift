//
//  UserNetworkManager.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/1/24.
//

import Foundation
import FirebaseFirestore

class UserNetworkManager {
    
    private let db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    // Subscribe to user bodyweight entries
    func subscribeToUser(userId: String, completion: @escaping ([BodyweightEntry]?, Error?) -> Void) {
        if listenerRegistration == nil {
            listenerRegistration = db.collection(FirebaseCollection.UserCollection.rawValue)
                .whereField(MovementAttributes.UserId.rawValue, isEqualTo: userId)
                .addSnapshotListener { querySnapshot, error in
                    if let error = error {
                        completion(nil, error)
                        return
                    }
                    guard let documents = querySnapshot?.documents else {
                        completion(nil, nil)
                        return
                    }
                    let bodyweightEntries = documents.compactMap { documentSnapshot in
                        try? documentSnapshot.data(as: BodyweightEntry.self)
                    }.sorted(by: { $0.timeAdded > $1.timeAdded })
                    completion(bodyweightEntries, nil)
                }
        }
    }
    
    // Unsubscribe from user updates
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    // Add a bodyweight entry
    func addBodyweight(_ bodyweight: BodyweightEntry) async -> FirebaseResult {
        do {
            try db.collection(FirebaseCollection.UserCollection.rawValue).document(bodyweight.id).setData(from: bodyweight)
            return .success
        } catch {
            return .failure(error)
        }
    }
    
    // Delete a bodyweight entry
    func deleteBodyweight(docId: String) async -> FirebaseResult {
        do {
            try await db.collection(FirebaseCollection.UserCollection.rawValue).document(docId).delete()
            return .success
        } catch {
            return .failure(error)
        }
    }
    
    // Delete all bodyweight entries for a user
    func deleteAllUserBodyweightEntries(for userId: String, bodyweightEntries: [BodyweightEntry]) async -> [FirebaseResult] {
        var results = [FirebaseResult]()
        for bodyweightEntry in bodyweightEntries {
            if bodyweightEntry.userId == userId {
                let result = await deleteBodyweight(docId: bodyweightEntry.id)
                results.append(result)
            }
        }
        return results
    }
}
