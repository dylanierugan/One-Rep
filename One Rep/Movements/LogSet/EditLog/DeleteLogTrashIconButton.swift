//
//  DeleteLogTrashIconButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI
import RealmSwift

struct DeleteLogTrashIconButton: View {
        
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var logController: LogController
    
    @ObservedRealmObject var movement: Movement
    
    var log: Log
    @Binding var selectedLog: Log
    
    var deleteLogInRealm: () -> Void

    // MARK: - View
    
    var body: some View {
        Button {
            selectedLog = log
            deleteLogInRealm()
            logViewModel.populateListOfWeights(movement.logs)
            logViewModel.filterWeightAndPopulateData(movement.logs)
            logController.setMostRecentLog(movement.logs, weightSelection: logViewModel.weightSelection)
            HapticManager.instance.impact(style: .light)
        } label: {
            Image(systemName: Icons.TrashCircleFill.description)
                .font(.title.weight(.regular))
                .foregroundStyle(.linearGradient(colors: [
                    Color(theme.lightRed),
                    Color(theme.lightRed),
                    Color(theme.darkRed)
                ], startPoint: .top, endPoint: .bottom))
        }
    }
}
