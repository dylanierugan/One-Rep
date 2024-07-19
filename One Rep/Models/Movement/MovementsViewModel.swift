//
//  MovementViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/27/24.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

@MainActor
class MovementsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var userId: String = ""
    @Published var movements = [Movement]()
    
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
    
    func subscribeToMovements(completion: @escaping (FirebaseResult) -> Void) {
        if listenerRegistration == nil {
            listenerRegistration = db.collection(FirebaseCollection.MovementCollection.rawValue)
                .whereField(MovementAttributes.UserId.rawValue, isEqualTo: userId)
                .addSnapshotListener() { querySnapshot, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    guard let documents = querySnapshot?.documents else {
                        return
                    }
                    self.movements = documents.compactMap { documentSnapshot in
                        try? documentSnapshot.data(as: Movement.self)
                    }
                    completion(.success)
                }
        }
    }
    
    func addMovement(movement: Movement) async -> FirebaseResult {
        do {
            try db.collection(FirebaseCollection.MovementCollection.rawValue).document(movement.id ).setData(from: movement)
            return .success
        } catch {
            return .failure(error)
        }
    }
    
    func deleteMovement(docId: String) async -> FirebaseResult {
        do {
            try await db.collection(FirebaseCollection.MovementCollection.rawValue).document(docId).delete()
            return .success
        } catch {
            return .failure(error)
        }
    }
    
}
