//
//  DeleteMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/3/24.
//

import SwiftUI

struct DeleteMovementButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Public Properties
    
    @Binding var deleteConfirmedClicked: Bool
    @Binding var showingDeleteMovementAlert: Bool
    var deleteMovementInFirebase: () -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            showingDeleteMovementAlert = true
        } label: {
            Text(EditMovementStrings.Delete.rawValue)
                .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                .foregroundStyle(.linearGradient(colors: [
                    Color(theme.lightRed),
                    Color(theme.darkRed)
                ], startPoint: .top, endPoint: .bottom))
        }
        .alert(isPresented: $showingDeleteMovementAlert) {
            Alert(
                title: Text(ErrorMessage.DeleteMovmentConfirmation.rawValue),
                message: Text(ErrorMessage.NoWayToUndo.rawValue),
                primaryButton: .destructive(Text(EditMovementStrings.Delete.rawValue)) {
                    deleteMovementInFirebase()
                    dismiss()
                },
                secondaryButton: .cancel())
        }
        .disabled(!deleteConfirmedClicked ? false : true)
    }
}
