//
//  DeleteMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/3/24.
//

import SwiftUI

struct DeleteMovementButton: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    @Environment(\.dismiss) private var dismiss
    
    @Binding var deleteConfirmedClicked: Bool
    @Binding var showingDeleteMovementAlert: Bool
    
    var deleteMovementInRealm: () -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            showingDeleteMovementAlert = true
        } label: {
            Text("Delete")
                .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                .foregroundStyle(Color(.primary))
        }
        /// Alert to delete movement (asks for confirmation)
        .alert(isPresented: $showingDeleteMovementAlert) {
            Alert(
                title: Text(ErrorMessage.DeleteMovmentConfirmation.description),
                message: Text(ErrorMessage.NoWayToUndo.description),
                primaryButton: .destructive(Text("Delete")) {
                    deleteMovementInRealm()
                    dismiss()
                },
                secondaryButton: .cancel())
        }
        .disabled(!deleteConfirmedClicked ? false : true)
    }
}
