//
//  DeleteLogTrashIconButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI

struct DeleteLogTrashIconButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var logController: LogController
    
    // MARK: - Public Properties
    
    @State var movement: Movement
    var log: Log
    @Binding var selectedLog: Log

    // MARK: - View
    
    var body: some View {
        Button {
            selectedLog = log
            Task {
                let result = await logViewModel.deleteLog(docId: log.id)
                handleDeleteLog(result: result, errorMessage: "")
            }
            HapticManager.instance.impact(style: .light)
        } label: {
            Image(systemName: Icons.TrashCircleFill.rawValue)
                .font(.title2.weight(.regular))
                .foregroundStyle(.linearGradient(colors: [
                    Color(theme.lightRed),
                    Color(theme.lightRed),
                    Color(theme.darkRed)
                ], startPoint: .top, endPoint: .bottom))
        }
    }
    
    // MARK: - Functions
    
    func handleDeleteLog(result: FirebaseResult?, errorMessage: String) {
        guard let result = result else { return }
        switch result {
        case .success:
            if logViewModel.checkIfWeightDeleted(movementId: movement.id, weightSelection: logViewModel.weightSelection) {
                logViewModel.repopulateViewModel(weightSelection: WeightSelection.all.rawValue, movement: movement)
            } else {
                logViewModel.repopulateViewModel(weightSelection: logViewModel.weightSelection, movement: movement)
            }
            logController.setMostRecentLog(logViewModel.filteredLogs, weightSelection: logViewModel.weightSelection)
            return
        case .failure(_):
            print(errorMessage)
        }
    }
}
