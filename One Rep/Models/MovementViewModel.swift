//
//  MovementViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/4/24.
//

import Foundation
import Combine
import FirebaseFirestore

class MovementViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var movement: Movement
    @Published var modified = false
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructors
    
    init(movement: Movement = Movement(id: "", userId: "", name: "", muscleGroup: .Arms, movementType: .Weight, timeAdded: 0, isPremium: false, mutatingValue: 0)) {
        self.movement = movement
        self.$movement
            .dropFirst()
            .sink { [weak self] movement in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    // MARK: - Firestore
    
    private var db = Firestore.firestore()
    
    func updateMovement() async -> FirebaseResult {
        do {
            try db.collection(FirebaseCollection.MovementCollection.rawValue).document(movement.id).setData(from: self.movement)
            return .success
        }
        catch {
            return .failure(error)
        }
    }
}
