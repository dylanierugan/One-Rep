//
//  UserViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/14/24.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

@MainActor
class UserViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var userId: String = ""
    @Published var bodyweightEntries: [BodyweightEntry] = []
    
    private let db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    // MARK: - Functions
    
    deinit {
        Task {
            await self.unsubscribe()
        }
    }
    
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    func clearData() {
        bodyweightEntries = []
    }
    
    func deleteAllUserBodyweightEntries() async -> [FirebaseResult] {
        var results = [FirebaseResult]()
        for bodyweightEntry in bodyweightEntries {
            if bodyweightEntry.userId == userId {
                let results = await self.deleteBodyweight(docId: bodyweightEntry.id)
            }
        }
        return results
    }
    
    func subscribeToUser(completion: @escaping (FirebaseResult) -> Void) {
        if listenerRegistration == nil {
            listenerRegistration = db.collection(FirebaseCollection.UserCollection.rawValue)
                .whereField(MovementAttributes.UserId.rawValue, isEqualTo: userId)
                .addSnapshotListener() { querySnapshot, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    guard let documents = querySnapshot?.documents else {
                        return
                    }
                    self.bodyweightEntries = documents.compactMap { documentSnapshot in
                        try? documentSnapshot.data(as: BodyweightEntry.self)
                    }.sorted(by: { $0.timeAdded > $1.timeAdded })
                    completion(.success)
                }
        }
    }
    
    func addBodyweight(bodyweight: BodyweightEntry) async -> FirebaseResult {
        do {
            try db.collection(FirebaseCollection.UserCollection.rawValue).document(bodyweight.id ).setData(from: bodyweight)
            return .success
        } catch {
            return .failure(error)
        }
    }
    
    func deleteBodyweight(docId: String) async -> FirebaseResult {
        do {
            try await db.collection(FirebaseCollection.UserCollection.rawValue).document(docId).delete()
            return .success
        } catch {
            return .failure(error)
        }
    }
}
