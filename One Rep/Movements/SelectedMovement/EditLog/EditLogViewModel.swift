//
//  EditLogViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/22/24.
//

import Foundation

class EditLogViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var log: Log
    
    @Published var reps: Int = 0
    @Published var repsStr = ""
    @Published var weight: Double = 0
    @Published var weightStr = ""
    @Published var bodyweight: Double = 0
    
    @Published var isDeletingLog = false
    @Published var isUpdatingLog = false
    @Published var date = Date()
    
    init(log: Log) {
        self.log = log
        reps = log.reps
        repsStr = String(log.reps)
        weight = log.weight
        weightStr = String(log.weight)
    }
    
    // MARK: - Firebase Functions
    
    func updateLog(userId: String, movement: Movement) {
        updateLog()
        isUpdatingLog = true
        Task {
            do {
                try await LogsNetworkManager.shared.updateLog(userId: userId,
                                                              movement: movement,
                                                              log: log)
            } catch {
                // TODO: - Handle error
            }
        }
        isUpdatingLog = false
    }
    
    func deleteLog(userId: String, movement: Movement)  {
        isDeletingLog = true
        Task {
            do {
                try await LogsNetworkManager.shared.deleteLog(userId: userId,
                                                              movement: movement,
                                                              log: log)
            } catch {
                // TODO: - Handle error
            }
        }
        isDeletingLog = false
    }
    
    // MARK: - Mutating Functions
    
    func mutateEditWeight(_ mutatingValue: Double) {
        if weight + mutatingValue >= 0 && weight + mutatingValue <= 999 {
            weight += mutatingValue
            weightStr = weight.clean
        }
    }
    
    func mutateEditReps(_ mutatingValue: Int) {
        if reps > 0 || reps < 999 {
            reps += mutatingValue
            repsStr = String(reps)
        }
    }
    
    func bindEditRepValues() {
        if repsStr.isEmpty {
            reps = 0
        } else if let value = Int(repsStr) {
            reps = value
        } else {
            repsStr = String(reps)
        }
    }
    
    func limitEditRepsText(_ upper: Int) {
        if repsStr.count > upper {
            repsStr = String(repsStr.prefix(upper))
        }
    }
    
    @MainActor
    func setEditingValues(userViewModel: UserViewModel) {
        date = log.timeAdded
        weight = log.weight
        weightStr = log.weight.clean
        reps = log.reps
        repsStr = String(log.reps)
        if let bodyweightEntry = userViewModel.bodyweightEntries.first {
            bodyweight = bodyweightEntry.bodyweight
        }
    }
    
    func updateLog() {
        log.weight = weight
        log.reps = reps
        log.timeAdded = date
        log.bodyweight = bodyweight
    }
}
