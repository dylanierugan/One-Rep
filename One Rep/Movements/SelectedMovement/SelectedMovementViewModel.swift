//
//  SelectedMovementViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/25/24.
//

import Foundation

class SelectedMovementViewModel: ObservableObject {
    
    init(movement: Movement) {
        self.movement = movement
    }
    
    // MARK: - Properties
    
    @Published var movement: Movement
    
    @Published var showEditMovementPopup = false
    @Published var showDoneToolBar = true
    @Published var showLogSetView = true
    @Published var isEditingLogs = false
    
    // MARK: - Functions
    
    func updateMovementMutatingValue(userId: String) { // TODO: Handle error
        Task {
            do {
                try await MovementsNetworkManager.shared.updateMovementMutatingValue(userId: userId, movement: movement)
            } catch {
                // TODO: Handle error
            }
        }
    }
}
