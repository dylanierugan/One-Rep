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
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var logViewModel: LogViewModel
    
    // MARK: - Public Properties
    
    @State var movement: Movement
    var log: Log
    @Binding var selectedLog: Log

    // MARK: - View
    
    var body: some View {
        Button {
            selectedLog = log
            Task {
                await handleDeleteLog()
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
    
    func handleDeleteLog() async {
        Task {
            let result = await logsViewModel.deleteLog(docId: log.id)
            ResultHandler.shared.handleResult(result: result, onSuccess: {
                if logsViewModel.checkIfWeightDeleted(movementId: movement.id, weightSelection: logsViewModel.weightSelection) {
                    logsViewModel.repopulateViewModel(weightSelection: WeightSelection.All.rawValue, movement: movement)
                } else {
                    logsViewModel.repopulateViewModel(weightSelection: logsViewModel.weightSelection, movement: movement)
                }
                logViewModel.setLastLog(logsViewModel.filteredLogs, weightSelection: logsViewModel.weightSelection, isBodyweight: movement.movementType == .Bodyweight ? true : false)
            })
        }
    }
}
