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
    
    // MARK: - Functions

    func loadRoutines(userId: String) async {
        do {
            routines = try await RoutineNetworkManager.shared.getRoutines(userId: userId)
        } catch {
            print(error.localizedDescription)
            // TODO: Handle error
        }
    }
    
    func updateRoutineInList(_ updatedRoutine: Routine) {
        if let index = routines.firstIndex(where: { $0.id == updatedRoutine.id }) {
            routines[index] = updatedRoutine
        }
    }
    
    func deleteRoutineInList(_ updatedRoutine: Routine) {
        if let index = routines.firstIndex(where: { $0.id == updatedRoutine.id }) {
            routines.remove(at: index)
        }
    }
    
    func clearRoutines() {
        routines = []
    }
}

