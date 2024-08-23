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
    @EnvironmentObject var errorHandler: ErrorHandler
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Public Properties
    
    @State var movement: Movement
    
    // MARK: - Private Properties
    
    @State private var addingLog = true
    
    // MARK: - View
    
    var body: some View {
        Button {
            logSet()
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
    
    func logSet() {
        let docId = UUID().uuidString
        
        var log = Log()
        
        /// If log is of type body weight and weight is added
        if movement.movementType == .Bodyweight && logViewModel.addWeightToBodyweight {
            if let bodyWeightEntry = userViewModel.bodyweightEntries.first {
                log = Log(
                    id: docId,
                    userId: logsViewModel.userId,
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
                    userId: logsViewModel.userId,
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
                userId: logsViewModel.userId,
                movementId: movement.id,
                reps: logViewModel.reps,
                weight: logViewModel.weight,
                bodyweight: 0,
                isBodyWeight: movement.movementType == .Bodyweight,
                timeAdded: Date.now.timeIntervalSince1970,
                unit: logsViewModel.unit
            )
        }
        
        Task {
            addingLog = true
            let result = await logsViewModel.addLog(log: log)
            errorHandler.handleLogSet(
                result: result,
                logsViewModel: logsViewModel,
                logViewModel: logViewModel,
                movement: movement
            )
        }
        
        HapticManager.instance.impact(style: .light)
    }
}
