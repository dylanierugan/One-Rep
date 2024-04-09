//
//  DeleteMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/3/24.
//

import SwiftUI

struct DeleteMovementButton: View {
    
    @EnvironmentObject var themeColor: ThemeColorModel
    @Binding var deleteConfirmedClicked: Bool
    @Binding var showingDeleteMovementAlert: Bool
    
    var body: some View {
        Button {
            showingDeleteMovementAlert = true
        } label: {
            HStack {
                Text("Delete Movement")
                    .font(.body.weight(.regular))
                Image(systemName: Icons.Trash.description)
                    .font(.body.weight(.medium))
            }
            .foregroundColor(.primary)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color(themeColor.BackgroundElement))
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
