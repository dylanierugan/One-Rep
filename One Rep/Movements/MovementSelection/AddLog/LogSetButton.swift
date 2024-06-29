//
//  LogSetButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct LogSetButton: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var logController: LogController
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var resultHandler: ResultHandler
    @EnvironmentObject var theme: ThemeModel
    @Environment(\.colorScheme) var colorScheme
    
    @State var movement: Movement
    @State var addingLog = true
    
    // MARK: - View
    
    var body: some View {
        Button {
            let docId = UUID().uuidString
            let log = Log(id: docId,
                          userId: logViewModel.userId,
                          movementId: movement.id,
                          reps: logController.reps,
                          weight: logController.weight,
                          isBodyWeight: movement.movementType == .Bodyweight ? true : false,
                          timeAdded: Date.now.timeIntervalSince1970,
                          unit: logViewModel.unit)
            Task {
                addingLog = true
                let result = await logViewModel.addLog(log: log)
                addingLog = false
                resultHandler.handleResultLogSet(result: result, errorMessage: ErrorMessage.ErrorAddMovement.rawValue)
            }
            HapticManager.instance.impact(style: .light)
        } label: {
            HStack {
                Text("Log")
                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
            }
            .foregroundStyle(Color(.customPrimary))
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                .linearGradient(colors: [
                    .secondary.opacity(0.05),
                    .secondary.opacity(0.05)
                ], startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(16)
            .foregroundColor(.white)
        }
    }
}
