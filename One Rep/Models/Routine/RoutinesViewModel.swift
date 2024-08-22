//
//  RoutinesViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/20/24.
//

import Foundation

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

@MainActor
class RoutinesViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var userId: String = ""
    @Published var routines = [Routine]()
    
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
        routines = []
    }
    
    func deleteAllUserRoutines() async -> [FirebaseResult] {
        var results = [FirebaseResult]()
        for routine in routines {
            if routine.userId == userId {
                let results = await self.deleteRoutine(docId: routine.id)
            }
        }
        return results
    }
    
    func subscribeToRoutines(completion: @escaping (FirebaseResult) -> Void) {
        if listenerRegistration == nil {
            listenerRegistration = db.collection(FirebaseCollection.RoutinesCollection.rawValue)
                .whereField(RoutineAttributes.UserId.rawValue, isEqualTo: userId)
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
                    self.routines = []
                    for document in querySnapshot.documents {
                        let docId = document.documentID
                        let userId = document[RoutineAttributes.UserId.rawValue] as? String ?? ""
                        let name = document[RoutineAttributes.Name.rawValue] as? String ?? ""
                        let icon = document[RoutineAttributes.Icon.rawValue] as? String ?? ""
                        let movementIds = document[RoutineAttributes.MovementIds.rawValue] as? [String] ?? []
                        print(movementIds)
                        let routine = Routine(id: docId, userId: userId, name: name, icon: icon, movementIDs: movementIds)
                        self.routines.append(routine)
                    }
                    completion(.success)
                }
        }
    }
    
    func addRoutine(routine: Routine) async -> FirebaseResult {
        do {
            try db.collection(FirebaseCollection.RoutinesCollection.rawValue).document(routine.id ).setData(from: routine)
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
    
}
