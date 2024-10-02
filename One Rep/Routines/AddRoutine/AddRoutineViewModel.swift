//
//  AddRoutineViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/29/24.
//

import Foundation

class AddRoutineViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var routineName = ""
    @Published var selectedIcon = Icons.Bench.rawValue
    @Published var showAddingRoutineProgressView = false
    @Published var dismissBothViews = false
    
    @Published var showSecondAddingRoutineProgressView = false
    @Published var muscleGroupMovementDict: [String: [Movement]] = [:]
    @Published var selectedMovments = [Movement]()
    @Published var selectedMovmentsIDs = [String]()
    
    var isFormNameValid: Bool {
        !routineName.isEmpty
    }
    
    var isFormSelectedMovementsValid: Bool {
        selectedMovments.count != 0
    }
    
    // MARK: - Functions
    
    func addRoutine(userId: String, addRoutineViewModel: AddRoutineViewModel) async -> Routine? {
        selectedMovmentsIDs = []
        for movement in selectedMovments {
            selectedMovmentsIDs.append(movement.id)
        }
        do {
            return try await RoutineNetworkManager.shared.addRoutine(userId: userId, addRoutineViewModel: addRoutineViewModel)
        } catch {
            // TODO: Handle error
        }
        return nil
    }
    
}
