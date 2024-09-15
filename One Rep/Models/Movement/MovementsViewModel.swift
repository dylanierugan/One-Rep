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
    
    private let networkManager = MovementsNetworkManager()
    
    // MARK: - Functions
    
    func subscribeToMovements(userId: String) {
        networkManager.subscribeToMovements(userId: userId) { [weak self] movements, error in
            if let error = error {
                // TODO: Handle error
                print("Error subscribing to movements: \(error.localizedDescription)")
                return
            }
            self?.movements = movements ?? []
            self?.movementsLoading = false
        }
    }
    
    func addMovement(_ movement: Movement) async -> FirebaseResult {
        return await networkManager.addMovement(movement)
    }
    
    func deleteMovement(docId: String) async -> FirebaseResult {
        return await networkManager.deleteMovement(docId: docId)
    }
    
    func deleteAllUserMovements(userId: String) async -> [FirebaseResult] {
        return await networkManager.deleteAllUserMovements(for: userId, movements: movements)
    }
    
    func unsubscribe() {
        networkManager.unsubscribe()
    }
    
    func clearData() {
        movements = []
    }
    
    deinit {
        Task {
            await self.unsubscribe()
        }
    }
}
