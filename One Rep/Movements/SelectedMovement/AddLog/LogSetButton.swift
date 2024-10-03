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

    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - View
    
    var body: some View {
        Button {
            Task {
                await logSet()
                updateViewModels()
            }
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
    
    private func updateViewModels() {
        logsViewModel.repopulateViewModel(movement: movement)
        logViewModel.setLastLog(logsViewModel.filteredLogs,
                                isBodyweight: movement.movementType == .Bodyweight ? true : false)
    }
    
    private func logSet() async {
        HapticManager.instance.impact(style: .soft)
        let newLog = await logViewModel.addLog(userId: userViewModel.userId,
                                         movement: movement, logViewModel: logViewModel,
                                         userViewModel: userViewModel,
                                         unit: logsViewModel.unit)
        guard let newLog = newLog else { return }
        logsViewModel.logs.append(newLog)
    }
}
