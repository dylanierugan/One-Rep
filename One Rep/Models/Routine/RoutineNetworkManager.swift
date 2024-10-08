//
//  RoutineNetworkManager.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/1/24.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

class RoutineNetworkManager {
    
    static let shared = RoutineNetworkManager()
    
    // MARK: - Properties
    
    private let userCollection: CollectionReference = Firestore.firestore().collection(FirebaseCollection.UserCollection.rawValue)
    
    private func userDocument(userId: String) -> DocumentReference {
        return userCollection.document(userId)
    }
    
    func routineCollection(userId: String) -> CollectionReference {
        return userDocument(userId: userId).collection(FirebaseCollection.RoutinesCollection.rawValue)
    }
    
    private func userRoutineDocument(userId: String, routineId: String) -> DocumentReference {
        return routineCollection(userId: userId).document(routineId)
    }
    
    // MARK: - Functions
    
    func getRoutines(userId: String) async throws -> [Routine] {
        let snapshot = try await routineCollection(userId: userId).getDocuments(as: Routine.self)
        var routines: [Routine] = []
        for document in snapshot {
            routines.append(document)
            print(routines)
        }
        return routines
    }
    
    func addRoutine(userId: String, addRoutineViewModel: AddRoutineViewModel) async throws -> Routine {
        let document = routineCollection(userId: userId).document()
        let newRoutine = await Routine(id: document.documentID,
                                 name: addRoutineViewModel.routineName,
                                 icon: addRoutineViewModel.selectedIcon,
                                 movementIDs: addRoutineViewModel.selectedMovmentsIDs,
                                 timeCreated: Date())
        let data: [String:Any] = [
            Routine.CodingKeys.id.rawValue : newRoutine.id,
            Routine.CodingKeys.name.rawValue : newRoutine.name,
            Routine.CodingKeys.icon.rawValue : newRoutine.icon,
            Routine.CodingKeys.movementIDs.rawValue : newRoutine.movementIDs,
            Routine.CodingKeys.timeCreated.rawValue : newRoutine.timeCreated,
        ]
        try await document.setData(data, merge: false)
        return newRoutine
    }
    
    func updateRoutineAttributes(userId: String, routine: Routine) async throws {
        let data: [String:Any] = [
            Routine.CodingKeys.name.rawValue : routine.name,
            Routine.CodingKeys.icon.rawValue : routine.icon,
        ]
        try await userRoutineDocument(userId: userId, routineId: routine.id).updateData(data)
    }
    
    func updateRoutineMovements(userId: String, routine: Routine) async throws {
        let data: [String:Any] = [
            Routine.CodingKeys.movementIDs.rawValue : routine.movementIDs,
        ]
        try await userRoutineDocument(userId: userId, routineId: routine.id).updateData(data)
    }

    func deleteRoutine(userId: String, routine: Routine) async throws {
        try await userRoutineDocument(userId: userId, routineId: routine.id).delete()
    }
    
    func deleteAllRoutines(userId: String) async throws {
        let routines = try await getRoutines(userId: userId)
        for routine in routines {
            let _ = try await deleteRoutine(userId: userId, routine: routine)
        }
    }
    
}
