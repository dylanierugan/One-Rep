//
//  SelectedRoutineViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import Foundation
import Combine
import FirebaseFirestore

class SelectedRoutineViewModel: ObservableObject {
    
    init(routine: Routine) {
        self.routine = routine
    }
    
    // MARK: - Properties
    
    @Published var routine: Routine
    
    @Published var movements = [Movement]()
    @Published private var movementIDdict = [String : Movement]()
    @Published var movementsToAdd: [Movement] = []
    
    // MARK: - Functions
    
    func updateRoutineMovementsList(userId: String) async {
        do {
            try await RoutineNetworkManager.shared.updateRoutineMovements(userId: userId, routine: routine)
        } catch {
            // TODO: - Handle error
        }
    }
    
    /// Sets array of movements that are not in Routine
    func setMovementsToAddArray(movements: [Movement], dismissAction: @escaping () -> Void) {
        movementsToAdd = []
        for movement in movements {
            if !routine.movementIDs.contains(movement.id) {
                movementsToAdd.append(movement)
            }
        }
        if movementsToAdd.count == 0 {
            dismissAction()
        }
    }
    
    func setMovements(userId: String, movements: [Movement]) {
        self.movements = []
        for movement in movements {
            movementIDdict[movement.id] = movement
        }
        for movementID in routine.movementIDs {
            if let movement = movementIDdict[movementID] {
                self.movements.append(movement)
            } else {
                /// If movement was deleted, remove it from the routine
                let index = routine.movementIDs.firstIndex(of: movementID)
                if let index = index {
                    Task {
                        try await RoutineNetworkManager.shared.updateRoutineMovements(userId: userId, routine: routine)
                        routine.movementIDs.remove(at: index)
                    }
                }
            }
        }
    }
}
