//
//  DeleteMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/3/24.
//

import SwiftUI

struct DeleteMovementButton: View {
    
    @EnvironmentObject var theme: ThemeModel
    @Binding var deleteConfirmedClicked: Bool
    @Binding var showingDeleteMovementAlert: Bool
    
    var body: some View {
        Button {
            showingDeleteMovementAlert = true
        } label: {
            HStack {
                Text("Delete")
                Image(systemName: Icons.Trash.description)
            }
            .customFont(size: .body, weight: .regular, kerning: 0, design: .rounded)
            .foregroundColor(.red)
            .padding(.vertical, 12)
            .padding(.horizontal, 32)
            .background(Color(.red).opacity(0.1))
            .cornerRadius(16)
        }
        /// Alert to delete movement (asks for confirmation)
        .alert(isPresented: $showingDeleteMovementAlert) {
            Alert(
                title: Text(ErrorMessage.DeleteMovmentConfirmation.description),
                message: Text(ErrorMessage.NoWayToUndo.description),
                primaryButton: .destructive(Text("Delete")) {
                    
                },
                secondaryButton: .cancel())
        }
        .disabled(!deleteConfirmedClicked ? false : true)
    }
}
