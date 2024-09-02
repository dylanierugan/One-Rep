//
//  RoutinesViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/20/24.
//

import Foundation

@MainActor
class RoutinesViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var routines = [Routine]()
    
    @Published var routinesLoading = false
    
    private let routineNetworkManager = RoutineNetworkManager()
    
    // MARK: - Functions
    
    deinit {
        Task {
            await self.unsubscribe()
        }
    }
    
    func unsubscribe() {
        routineNetworkManager.unsubscribe()
    }
    
    func clearData() {
        routines = []
    }
    
    func deleteAllUserRoutines(userId: String) async -> [FirebaseResult] {
        var results = [FirebaseResult]()
        for routine in routines {
            if routine.userId == userId {
                let result = await routineNetworkManager.deleteRoutine(docId: routine.id)
                results.append(result)
            }
        }
        return results
    }
    
    func subscribeToRoutines(userId: String) {
        routineNetworkManager.subscribeToRoutines(userId: userId) { [weak self] routines, error in
            if let error = error {
                print("Error subscribing to routines: \(error)")
                return
            }
            self?.routines = routines ?? []
            self?.routinesLoading = false
        }
    }
    
    func addRoutine(_ routine: Routine) async -> FirebaseResult {
        return await routineNetworkManager.addRoutine(routine)
    }
    
    func deleteRoutine(_ routine: Routine) async -> FirebaseResult {
        return await routineNetworkManager.deleteRoutine(docId: routine.id)
    }
}

