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
    
    // MARK: - Firestore
    
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
}
