//
//  MovementViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/27/24.
//

import Foundation

@MainActor
class MovementsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var movements = [Movement]()
    
    @Published var movementsLoading = true
    @Published var currentMuscleSelection: MuscleGroup = .All
    
    @Published private var searchText = ""
    var filteredMovements: [Movement] {
        if searchText.isEmpty {
            return movements.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        } else {
            return movements
                .filter { $0.name.range(of: searchText, options: [.caseInsensitive, .diacriticInsensitive]) != nil }
                .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        }
    }
    
    // MARK: - Functions
    
    func loadMovements(userId: String) async throws {
        do {
            movements = try await MovementsNetworkManager.shared.getMovements(userId: userId)
        } catch {
            // TODO: Handle error
        }
        movementsLoading = false
    }
    
    func updateMovementInList(_ updatedMovement: Movement) {
        if let index = movements.firstIndex(where: { $0.id == updatedMovement.id }) {
            movements[index] = updatedMovement
        }
    }
    
    func deleteMovementInList(_ movement: Movement) {
        if let index = movements.firstIndex(where: { $0.id == movement.id }) {
            movements.remove(at: index)
        }
    }
    
    func clearMovments() {
        movements = []
    }
    
    func deleteAllMovements(userId: String) { // TODO: Handle error
        Task {
            try await MovementsNetworkManager.shared.deleteAllMovements(userId: userId)
        }
    }
    
}
