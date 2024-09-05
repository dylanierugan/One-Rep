//
//  LogSetButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct LogSetButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - Public Properties
    
    @State var movement: Movement
    
    // MARK: - Private Properties
    
    @State private var addingLog = true
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - View
    
    var body: some View {
        Button {
            logSetInFirebase()
        } label: {
            HStack {
                Text(LogSetString.Log.rawValue)
                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
            }
            .foregroundStyle(Color(.customPrimary))
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                .linearGradient(colors: [
                    .secondary.opacity(0.075),
                ], startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(16)
            .foregroundColor(.white)
        }
    }
    
    // MARK: - Functions
    
    private func buildAndReturnLog(userId: String) -> Log {
        let docId = UUID().uuidString
        var log = Log()
        /// If log is of type body weight and weight is added
        if movement.movementType == .Bodyweight && logViewModel.addWeightToBodyweight {
            if let bodyWeightEntry = userViewModel.bodyweightEntries.first {
                log = Log(
                    id: docId,
                    userId: userId,
                    movementId: movement.id,
                    reps: logViewModel.reps,
                    weight: logViewModel.weight,
                    bodyweight: bodyWeightEntry.bodyweight,
                    isBodyWeight: movement.movementType == .Bodyweight,
                    timeAdded: Date.now.timeIntervalSince1970,
                    unit: logsViewModel.unit
                )
            }
        } else if movement.movementType == .Bodyweight && !logViewModel.addWeightToBodyweight {
            if let bodyWeightEntry = userViewModel.bodyweightEntries.first {
                log = Log(
                    id: docId,
                    userId: userId,
                    movementId: movement.id,
                    reps: logViewModel.reps,
                    weight: 0,
                    bodyweight: bodyWeightEntry.bodyweight,
                    isBodyWeight: movement.movementType == .Bodyweight,
                    timeAdded: Date.now.timeIntervalSince1970,
                    unit: logsViewModel.unit
                )
            }
        } else {
            log = Log(
                id: docId,
                userId: userId,
                movementId: movement.id,
                reps: logViewModel.reps,
                weight: logViewModel.weight,
                bodyweight: 0,
                isBodyWeight: movement.movementType == .Bodyweight,
                timeAdded: Date.now.timeIntervalSince1970,
                unit: logsViewModel.unit
            )
        }
        return log
    }
    
    private func handeSuccessLog() {
        if logsViewModel.weightSelection != WeightSelection.All.rawValue  {
            logsViewModel.repopulateViewModel(weightSelection: logViewModel.weightStr, movement: movement)
        } else {
            logsViewModel.repopulateViewModel(weightSelection: WeightSelection.All.rawValue , movement: movement)
        }
        logViewModel.setLastLog(logsViewModel.filteredLogs, weightSelection: logsViewModel.weightSelection, isBodyweight: movement.movementType == .Bodyweight ? true : false)
    }
    
    private func logSetInFirebase() {
        addingLog = true
        let log = buildAndReturnLog(userId: userViewModel.userId)
        Task {
            let result = await logsViewModel.addLog(log)
            ResultHandler.shared.handleResult(result: result, onSuccess: {
                handeSuccessLog()
            }) // Todo - Error handle
        }
        HapticManager.instance.impact(style: .light)
    }
}
