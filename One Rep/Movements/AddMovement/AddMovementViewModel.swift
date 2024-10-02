//
//  AddMovementViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/25/24.
//

import Foundation

@MainActor
class AddMovementViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var movementName = ""
    @Published var muscleGroup: MuscleGroup = .Arms
    @Published var movementType: MovementType = .Weight
    
    var isFormValid: Bool {
        !movementName.isEmpty
    }
    
    @Published var showAddingMovementProgressView = false
    
    // MARK: - Functions
    
    func addMovement(userId: String, addMovementViewModel: AddMovementViewModel) async -> Movement? {
        showAddingMovementProgressView = true
        defer { showAddingMovementProgressView = false }
        do {
            return try await MovementsNetworkManager.shared.addMovement(userId: userId, addMovementViewModel: addMovementViewModel)
        } catch {
            // TODO: Handle error
        }
        return nil
    }
}
