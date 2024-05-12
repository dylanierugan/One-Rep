//
//  DeleteLogButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI
import RealmSwift

struct DeleteLogButton: View {
    
    // MARK: - Variable
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logDataController: LogDataController
    
    @ObservedRealmObject var movement: Movement
    
    var log: Log
    @Binding var selectedLog: Log
    
    var deleteLogInRealm: () -> Void

    // MARK: - View
    
    var body: some View {
        Button {
            selectedLog = log
            deleteLogInRealm()
            logDataController.populateListOfWeights(movement.logs)
            logDataController.filterWeightAndPopulateData(movement.logs)
            logDataController.setMostRecentLog(movement.logs)
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
