//
//  LogViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/22/24.
//

import Foundation

class LogViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var lastLog: Log? = nil
    
    @Published var reps: Int = 0
    @Published var repsStr = ""
    @Published var weight: Double = 0
    @Published var weightStr = ""
    @Published var addWeightToBodyweight: Bool = false
    
    // MARK: - Functions
    
    @MainActor 
    func addLog(userId: String, movement: Movement, userViewModel: UserViewModel, unit: UnitSelection) -> Log {
        let newLog = buildAndReturnLog(userId: userId, movement: movement, userViewModel: userViewModel, unit: unit)
        Task {
            do {
                try await LogsNetworkManager.shared.addLog(userId: userId,
                                                           movement: movement,
                                                           newLog: newLog)
            } catch {
                // TODO: Handle error
            }
        }
        return newLog
    }
    
    @MainActor 
    func buildAndReturnLog(userId: String,
                           movement: Movement,
                           userViewModel: UserViewModel,
                           unit: UnitSelection) -> Log {
        let docId = UUID().uuidString
        var log = Log()
        if let bodyWeightEntry = userViewModel.bodyweightEntries.first {
            log = Log(
                id: docId,
                userId: userId,
                movementId: movement.id,
                reps: reps,
                weight: weight,
                bodyweight: bodyWeightEntry.bodyweight,
                isBodyWeight: movement.movementType == .Bodyweight,
                timeAdded: Date(),
                unit: unit
            )
        } else {
            log = Log(
                id: docId,
                userId: userId,
                movementId: movement.id,
                reps: reps,
                weight: weight,
                bodyweight: 0,
                isBodyWeight: movement.movementType == .Bodyweight,
                timeAdded: Date(),
                unit: unit)
        }
        return log
    }
    
    // MARK: - Mutating Functions
    
    func setLastLog(_ logs: [Log], isBodyweight: Bool) {
        lastLog = logs.first
        reps = lastLog?.reps ?? 12
        repsStr = String(lastLog?.reps ?? 12)
        weight = lastLog?.weight ?? 135
        weightStr = String(lastLog?.weight ?? 135)
    }
    
    func mutateWeight(_ mutatingValue: Double) {
        if weight + mutatingValue >= 0 && weight + mutatingValue <= 999 {
            weight += mutatingValue
            weightStr = weight.clean
        }
    }
    
    func mutateReps(_ mutatingValue: Int) {
        if reps > 0 || reps < 999 {
            reps += mutatingValue
            repsStr = String(reps)
        }
    }
    
    func bindRepValues() {
        if repsStr.isEmpty {
            reps = 0
        } else if let value = Int(repsStr) {
            reps = value
        } else {
            repsStr = String(reps)
        }
    }
    
    func limitRepsText(_ upper: Int) {
        if repsStr.count > upper {
            repsStr = String(repsStr.prefix(upper))
        }
    }
}

// MARK: - Extensions

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension NumberFormatter {
    static var noDecimalUnlessNeeded: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        return formatter
    }
}
