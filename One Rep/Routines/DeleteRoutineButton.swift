//
//  DeleteRoutineButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/7/24.
//

import SwiftUI

struct DeleteRoutineButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Public Properties
    
    @Binding var deleteConfirmedClicked: Bool
    @Binding var showingDeleteRoutineAlert: Bool
    var deleteRoutineInFirebase: () -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            showingDeleteRoutineAlert = true
        } label: {
            Text(EditMovementStrings.Delete.rawValue)
                .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                .foregroundStyle(.linearGradient(colors: [
                    Color(theme.lightRed),
                    Color(theme.darkRed)
                ], startPoint: .top, endPoint: .bottom))
        }
        .alert(isPresented: $showingDeleteRoutineAlert) {
            Alert(
                title: Text(ErrorMessage.DeleteRoutineConfirmation.rawValue),
                message: Text(ErrorMessage.NoWayToUndo.rawValue),
                primaryButton: .destructive(Text(EditRoutineStrings.Delete.rawValue)) {
                    deleteRoutineInFirebase()
                    dismiss()
                },
                secondaryButton: .cancel())
        }
        .disabled(!deleteConfirmedClicked ? false : true)
    }
}
