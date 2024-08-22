//
//  RoutineViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import Foundation
import Combine
import FirebaseFirestore

class RoutineViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var routine: Routine
    @Published var modified = false
    @Published var movements = [Movement]()
    
    @Published private var movementIDdict = [String : Movement]()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructors
    
    init(routine: Routine = Routine(id: "", userId: "", name: "", icon: "", movementIDs: [])) {
        self.routine = routine
        self.$routine
            .dropFirst()
            .sink { [weak self] routine in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    // MARK: - Functions 
    
    private var db = Firestore.firestore()
    
    func updateRoutine() async -> FirebaseResult {
        do {
            try db.collection(FirebaseCollection.RoutinesCollection.rawValue).document(routine.id).setData(from: self.routine)
            return .success
        }
        catch {
            return .failure(error)
        }
    }
    
    func setMovements(movements: [Movement], errorHandler: ErrorHandler) {
        self.movements = []
        for movement in movements {
            movementIDdict[movement.id] = movement
        }
        for movementID in routine.movementIDs {
            if let movement = movementIDdict[movementID] {
                self.movements.append(movement)
            } else {
                let index = routine.movementIDs.firstIndex(of: movementID)
                if let index = index {
                    routine.movementIDs.remove(at: index)
                    Task {
                        let result = await updateRoutine()
                        errorHandler.handleUpdateRoutine(result: result, dismiss: nil)
                    }
                }
            }
        }
    }
}
