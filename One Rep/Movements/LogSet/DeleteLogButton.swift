//
//  DeleteLogButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI

struct DeleteLogButton: View {
    
    // MARK: - Variable
    
    @EnvironmentObject var theme: ThemeModel
    
    var log: Log
    @Binding var selectedLog: Log
    
    var deleteLogInRealm: () -> Void
    var populateListOfWeights: () -> Void
    var filterWeightAndPopulateData: () -> Void
    var setMostRecentLog: () -> Void

    // MARK: - View
    
    var body: some View {
        Button {
            selectedLog = log
            deleteLogInRealm()
            populateListOfWeights()
            filterWeightAndPopulateData()
            setMostRecentLog()
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
