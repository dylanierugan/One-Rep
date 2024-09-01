//
//  MovementNetworkManager.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/1/24.
//

import Firebase
import FirebaseFirestore

class MovementsNetworkManager {
    
    private let db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    func subscribeToMovements(userId: String, completion: @escaping ([Movement]?, Error?) -> Void) {
        if listenerRegistration == nil {
            listenerRegistration = db.collection(FirebaseCollection.MovementCollection.rawValue)
                .whereField(MovementAttributes.UserId.rawValue, isEqualTo: userId)
                .addSnapshotListener { querySnapshot, error in
                    if let error = error {
                        completion(nil, error)
                        return
                    }
                    guard let querySnapshot = querySnapshot else {
                        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])
                        completion(nil, error)
                        return
                    }
                    var movements = [Movement]()
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
                        let movement = Movement(id: docId, userId: userId, name: name, muscleGroup: muscleGroup, movementType: movementType, timeAdded: timeAdded, isPremium: isPremium, mutatingValue: mutatingValue)
                        movements.append(movement)
                    }
                    completion(movements, nil)
                }
        }
    }
    
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    func addMovement(_ movement: Movement) async -> FirebaseResult {
        do {
            try db.collection(FirebaseCollection.MovementCollection.rawValue).document(movement.id).setData(from: movement)
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

    func deleteAllUserMovements(for userId: String, movements: [Movement]) async -> [FirebaseResult] {
        var results = [FirebaseResult]()
        for movement in movements {
            if movement.userId == userId {
                let result = await deleteMovement(docId: movement.id)
                results.append(result)
            }
        }
        return results
    }
}
