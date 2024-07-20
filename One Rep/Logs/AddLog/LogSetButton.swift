//
//  LogSetButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct LogSetButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var logController: LogController
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var theme: ThemeModel
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
        if movement.movementType == .Bodyweight && logController.addWeightToBodyweight {
            if let bodyWeightEntry = userViewModel.bodyweightEntries.first {
                log = Log(
                    id: docId,
                    userId: logViewModel.userId,
                    movementId: movement.id,
                    reps: logController.reps,
                    weight: logController.weight,
                    bodyweight: bodyWeightEntry.bodyweight,
                    isBodyWeight: movement.movementType == .Bodyweight,
                    timeAdded: Date.now.timeIntervalSince1970,
                    unit: logViewModel.unit
                )
            }
        } else if movement.movementType == .Bodyweight && !logController.addWeightToBodyweight {
            if let bodyWeightEntry = userViewModel.bodyweightEntries.first {
                log = Log(
                    id: docId,
                    userId: logViewModel.userId,
                    movementId: movement.id,
                    reps: logController.reps,
                    weight: 0,
                    bodyweight: bodyWeightEntry.bodyweight,
                    isBodyWeight: movement.movementType == .Bodyweight,
                    timeAdded: Date.now.timeIntervalSince1970,
                    unit: logViewModel.unit
                )
            }
        } else {
            if let bodyWeightEntry = userViewModel.bodyweightEntries.first {
                log = Log(
                    id: docId,
                    userId: logViewModel.userId,
                    movementId: movement.id,
                    reps: logController.reps,
                    weight: logController.weight,
                    bodyweight: 0,
                    isBodyWeight: movement.movementType == .Bodyweight,
                    timeAdded: Date.now.timeIntervalSince1970,
                    unit: logViewModel.unit
                )
            }
        }

        Task {
            addingLog = true
            let result = await logViewModel.addLog(log: log)
            errorHandler.handleLogSet(
                result: result,
                logViewModel: logViewModel,
                logController: logController,
                movement: movement
            )
        }

        HapticManager.instance.impact(style: .light)
    }
}
