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
            errorHandler.handleLogSet(result: result, logViewModel: logViewModel, logController: logController, movement: movement)
        }
        HapticManager.instance.impact(style: .light)
    }
}
