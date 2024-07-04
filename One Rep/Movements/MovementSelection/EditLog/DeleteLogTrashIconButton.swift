//
//  DeleteLogTrashIconButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI

struct DeleteLogTrashIconButton: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var logController: LogController
    
    @State var movement: Movement
    
    var log: Log
    @Binding var selectedLog: Log

    // MARK: - View
    
    var body: some View {
        Button {
            selectedLog = log
            Task {
                let result = await logViewModel.deleteLog(docId: log.id)
                logViewModel.repopulateViewModel(weightSelection: logViewModel.weightSelection, movement: movement)
                logController.setMostRecentLog(logViewModel.filteredLogs, weightSelection: logViewModel.weightSelection)
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
    
    func handleDeleteLog(result: FirebaseResult?, errorMessage: String) {
        guard let result = result else { return }
        switch result {
        case .success:
            return
        case .failure(_):
            print(errorMessage)
        }
    }
}
