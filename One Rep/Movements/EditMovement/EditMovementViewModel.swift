//
//  EditMovementViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/25/24.
//

import Foundation

@MainActor
class EditMovementViewModel: ObservableObject {
    
    init(movement: Movement) {
        self.movement = movement
    }
    
    // MARK: - Properties
    
    @Published var movement: Movement
    
    @Published var newMovementName = ""
    @Published var newMovementType: MovementType = .Weight
    @Published var newMuscleGroup: MuscleGroup = .Arms
    
    @Published var deleteConfirmedClicked = false
    @Published var showingDeleteMovementAlert = false
    @Published var showEditingMovementProgressView = false
    @Published var showDeletingMovementProgressView = false
    
    
    // MARK: - Functions
    
    func setEditableAttributes() {
        newMovementName = movement.name
        newMovementType = movement.movementType
        newMuscleGroup = movement.muscleGroup
    }
    
    func setNewMovementAttributes() {
        movement.name = newMovementName
        movement.movementType = newMovementType
        movement.muscleGroup = newMuscleGroup
    }
    
    func updateMovementAttributes(userId: String) {
        setNewMovementAttributes()
        showEditingMovementProgressView = true
        Task {
            do {
                try await MovementsNetworkManager.shared.updateMovementAttributes(userId: userId, movement: movement)
            } catch {
                // TODO: Handle error
            }
        }
        showEditingMovementProgressView = false
    }
    
    func deleteMovement(userId: String) {
        showDeletingMovementProgressView = true
        Task {
            do {
                try await MovementsNetworkManager.shared.deleteMovement(userId: userId, movementId: movement.id)
            } catch {
                // TODO: Handle error
            }
        }
        showDeletingMovementProgressView = false
    }
    
}
