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
    
    private let db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    func subscribeToRoutines(userId: String, completion: @escaping ([Routine]?, Error?) -> Void) {
        if listenerRegistration == nil {
            listenerRegistration = db.collection(FirebaseCollection.RoutinesCollection.rawValue)
                .whereField(RoutineAttributes.UserId.rawValue, isEqualTo: userId)
                .addSnapshotListener { querySnapshot, error in
                    if let error = error {
                        completion(nil, error)
                        return
                    }
                    guard let querySnapshot = querySnapshot else {
                        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Snapshot missing"])
                        completion(nil, error)
                        return
                    }
                    var routines = [Routine]()
                    for document in querySnapshot.documents {
                        let docId = document.documentID
                        let userId = document[RoutineAttributes.UserId.rawValue] as? String ?? ""
                        let name = document[RoutineAttributes.Name.rawValue] as? String ?? ""
                        let icon = document[RoutineAttributes.Icon.rawValue] as? String ?? ""
                        let movementIds = document[RoutineAttributes.MovementIds.rawValue] as? [String] ?? []
                        let routine = Routine(id: docId, userId: userId, name: name, icon: icon, movementIDs: movementIds)
                        routines.append(routine)
                    }
                    completion(routines, nil)
                }
        }
    }
    
    func addRoutine(_ routine: Routine) async -> FirebaseResult {
        do {
            try db.collection(FirebaseCollection.RoutinesCollection.rawValue).document(routine.id).setData(from: routine)
            return .success
        } catch {
            return .failure(error)
        }
    }

    func deleteRoutine(docId: String) async -> FirebaseResult {
        do {
            try await db.collection(FirebaseCollection.RoutinesCollection.rawValue).document(docId).delete()
            return .success
        } catch {
            return .failure(error)
        }
    }
    
    func unsubscribe() {
        listenerRegistration?.remove()
        listenerRegistration = nil
    }
}
