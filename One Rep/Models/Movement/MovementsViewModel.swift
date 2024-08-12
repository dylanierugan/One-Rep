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
    
    func clearData() {
        movements = []
    }
    
    func subscribeToMovements(completion: @escaping (FirebaseResult) -> Void) {
        if listenerRegistration == nil {
            listenerRegistration = db.collection(FirebaseCollection.MovementCollection.rawValue)
                .whereField(MovementAttributes.UserId.rawValue, isEqualTo: userId)
                .addSnapshotListener { querySnapshot, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    guard let querySnapshot = querySnapshot else {
                        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: ""])
                        completion(.failure(error))
                        return
                    }
                    self.movements = []
                    for document in querySnapshot.documents {
                        let docId = document.documentID
                        let userId = document[MovementAttributes.UserId.rawValue] as? String ?? ""
                        let name = document[MovementAttributes.Name.rawValue] as? String ?? ""
                        let muscleGroupString = document[MovementAttributes.MuscleGroup.rawValue] as? String ?? ""
                        let muscleGroup = MuscleGroup(rawValue: muscleGroupString) ?? MuscleGroup.Arms
                        let movementTypeString = document[MovementAttributes.MovementType.rawValue] as? String ?? ""
                        let movementType = MovementType(rawValue: movementTypeString) ?? MovementType.Weight
                        let timeAdded = document[MovementAttributes.TimeAdded.rawValue] as? Double ?? 0
                        let isPremium = document[MovementAttributes.IsPremium.rawValue] as? Bool ?? false
                        let mutatingValue = document[MovementAttributes.MutatingValue.rawValue] as? Double ?? 0
                        let routineIds = document[MovementAttributes.RoutineIds.rawValue] as? [String] ?? []
                        let movement = Movement(id: docId, userId: userId, name: name, muscleGroup: muscleGroup, movementType: movementType, timeAdded: timeAdded, isPremium: isPremium, mutatingValue: mutatingValue)
                        self.movements.append(movement)
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
