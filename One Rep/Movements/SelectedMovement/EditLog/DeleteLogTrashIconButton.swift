//
//  DeleteLogTrashIconButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI

@MainActor
struct DeleteLogTrashIconButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var editLogViewModel: EditLogViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    
    // MARK: - Public Properties
    
    @ObservedObject var selectedMovementViewModel: SelectedMovementViewModel
    
    // MARK: - Public Properties
    
    var movement: Movement
    var log: Log

    // MARK: - View
    
    var body: some View {
        Button {
            Task {
                await deleteLog()
            }
            HapticManager.instance.impact(style: .light)
        } label: {
            Image(systemName: Icons.TrashFill.rawValue)
                .font(.body.weight(.regular))
                .foregroundStyle(.linearGradient(colors: [
                    Color(theme.lightRed),
                    Color(theme.lightRed),
                    Color(theme.darkRed)
                ], startPoint: .top, endPoint: .bottom))
        }
    }
    
    // MARK: - Functions
    
    private func deleteLog() async {
        editLogViewModel.log = log
        await editLogViewModel.deleteLog(userId: userViewModel.userId,
                                   movement: movement)
        logsViewModel.deleteLogInLocalList(log)
        logsViewModel.repopulateViewModel(movement: movement)
        logViewModel.setLastLog(logsViewModel.filteredLogs,
                                isBodyweight: movement.movementType == .Bodyweight ? true : false)
        HapticManager.instance.impact(style: .light)
        if logsViewModel.filteredLogs.isEmpty {
            selectedMovementViewModel.isEditingLogs = false
        }
    }
}
