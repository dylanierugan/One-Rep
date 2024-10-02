//
//  MovementNetworkManager.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/1/24.
//

import Firebase
import FirebaseFirestore

class MovementsNetworkManager {
    
    static let shared = MovementsNetworkManager()
    
    // MARK: - Properties
    
    private let userCollection: CollectionReference = Firestore.firestore().collection(FirebaseCollection.UserCollection.rawValue)
    
    private func userDocument(userId: String) -> DocumentReference {
        return userCollection.document(userId)
    }
    
    func movementCollection(userId: String) -> CollectionReference {
        return userDocument(userId: userId).collection(FirebaseCollection.MovementCollection.rawValue)
    }
    
    private func userMovementDocument(userId: String, movementId: String) -> DocumentReference {
        return movementCollection(userId: userId).document(movementId)
    }
    
    // MARK: - Functions
    
    func getMovements(userId: String) async throws -> [Movement] {
        let snapshot = try await movementCollection(userId: userId).getDocuments(as: Movement.self)
        var movements: [Movement] = []
        for document in snapshot {
            movements.append(document)
        }
        return movements
    }
    
    func addMovement(userId: String, addMovementViewModel: AddMovementViewModel) async throws -> Movement {
        let document = movementCollection(userId: userId).document()
        let newMovement = await Movement(id: document.documentID,
                                   name: addMovementViewModel.movementName,
                                   muscleGroup: addMovementViewModel.muscleGroup,
                                   movementType: addMovementViewModel.movementType,
                                   timeCreated: Date(),
                                   isPremium: false,
                                   mutatingValue: 5.0)
        let data: [String:Any] = [
            Movement.CodingKeys.id.rawValue : newMovement.id,
            Movement.CodingKeys.name.rawValue : newMovement.name,
            Movement.CodingKeys.muscleGroup.rawValue : newMovement.muscleGroup.rawValue,
            Movement.CodingKeys.movementType.rawValue : newMovement.movementType.rawValue,
            Movement.CodingKeys.timeCreated.rawValue : newMovement.timeCreated,
            Movement.CodingKeys.isPremium.rawValue : newMovement.isPremium,
            Movement.CodingKeys.mutatingValue.rawValue : newMovement.mutatingValue,
        ]
        try await document.setData(data, merge: false)
        return newMovement
    }
    
    func updateMovementAttributes(userId: String, movement: Movement) async throws {
        let data: [String:Any] = [
            Movement.CodingKeys.name.rawValue : movement.name,
            Movement.CodingKeys.muscleGroup.rawValue : movement.muscleGroup.rawValue,
            Movement.CodingKeys.movementType.rawValue : movement.movementType.rawValue,
        ]
        try await userMovementDocument(userId: userId, movementId: movement.id).updateData(data)
    }
    
    func updateMovementMutatingValue(userId: String, movement: Movement) async throws {
        let data: [String:Any] = [
            Movement.CodingKeys.mutatingValue.rawValue : movement.mutatingValue,
        ]
        try await userMovementDocument(userId: userId, movementId: movement.id).updateData(data)
    }
    
    func deleteMovement(userId: String, movement: Movement) async throws {
        try await userMovementDocument(userId: userId, movementId: movement.id).delete()
    }
    
    func deleteMovementNoReturn(userId: String, movement: Movement) async throws {
        try await userMovementDocument(userId: userId, movementId: movement.id).delete()
    }
    
    func deleteAllMovements(userId: String) async throws {
        let movements = try await getMovements(userId: userId)
        for movement in movements {
            let _ = try await deleteMovementNoReturn(userId: userId, movement: movement)
        }
    }
}
