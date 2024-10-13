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
    var routineCapReached: Bool {
        return routines.count >= 2
    }
    
    @Published var routinesLoading = true
    
    // MARK: - Functions

    func loadRoutines(userId: String) async {
        defer { routinesLoading = false }
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
    
    func deleteAllRoutines(userId: String) async {
        do {
            try await RoutineNetworkManager.shared.deleteAllRoutines(userId: userId)
        } catch {
            // TODO: Handle error
        }
    }
    
    func clearRoutines() {
        routines = []
    }
}

