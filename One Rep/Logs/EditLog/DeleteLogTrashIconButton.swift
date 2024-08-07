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
    @EnvironmentObject var errorHandler: ErrorHandler
    
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
            let result = await logViewModel.deleteLog(docId: log.id)
            errorHandler.handleDeleteLog(result: result, logViewModel: logViewModel, logController: logController, movement: movement)
        }
    }
}
