//
//  LogSetButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct LogSetButton: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var logController: LogController
    @EnvironmentObject var logViewModel: LogViewModel
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
                handleResultLogSet(result: result, errorMessage: ErrorMessage.ErrorAddMovement.rawValue)
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
                    .secondary.opacity(0.075),
                ], startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(16)
            .foregroundColor(.white)
        }
    }
    
    func handleResultLogSet(result: FirebaseResult?, errorMessage: String) {
        guard let result = result else { return }
        switch result {
        case .success:
            if logViewModel.weightSelection != WeightSelection.all.rawValue  {
                logViewModel.repopulateViewModel(weightSelection: logController.weightStr, movement: movement)
            } else {
                logViewModel.repopulateViewModel(weightSelection: WeightSelection.all.rawValue , movement: movement)
            }
            logController.setMostRecentLog(logViewModel.filteredLogs, weightSelection: logViewModel.weightSelection)
            return
        case .failure(_):
            print(errorMessage)
        }
    }
}
