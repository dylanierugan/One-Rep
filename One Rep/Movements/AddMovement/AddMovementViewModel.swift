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
    
    func addMovement(userId: String) async -> Movement {
        let docId = UUID().uuidString
        let newMovement = Movement(id: docId,
                                   name: movementName,
                                   muscleGroup: muscleGroup,
                                   movementType: movementType,
                                   timeCreated: Date(),
                                   isPremium: false,
                                   mutatingValue: 5.0)
        showAddingMovementProgressView = true
        defer { showAddingMovementProgressView = false }
        do {
            try await MovementsNetworkManager.shared.addMovement(userId: userId, newMovement: newMovement)
        } catch {
            // TODO: Handle error
        }
        return newMovement
    }
}
