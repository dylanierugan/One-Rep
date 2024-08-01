//
//  DeleteAccountButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/24/24.
//

import SwiftUI
import FirebaseAuth

struct DeleteAccountButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    // MARK: - Global Properties
    
    @State private var showDeleteMovementAlert = false
    
    // MARK: - View
    
    var body: some View {
        Button {
            showDeleteMovementAlert = true
        } label: {
            HStack(spacing: 16) {
                Image(systemName: Icons.Trash.rawValue)
                Text("Delete Account")
                Spacer()
            }
            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
            .foregroundStyle(.linearGradient(colors: [
                Color(theme.lightRed),
                Color(theme.darkRed)
            ], startPoint: .top, endPoint: .bottom))
        }
        .alert(isPresented: $showDeleteMovementAlert) {
            Alert(
                title: Text("Are you sure you want to delete your account and all the data associated with it?"),
                message: Text("There is no way to undo this action."),
                primaryButton: .destructive(Text("Delete")) {

                },
                secondaryButton: .cancel())
        }
    }
    
    // MARK: - Function
    
    private func deleteUser() {
        let user = Auth.auth().currentUser
        user?.delete { error in
          if let error = error {
              /// TODO - Error handle
              print(error)
          } else {
              deleteAllData()
              viewRouter.currentPage = .loginView
          }
        }
    }
    
    private func deleteAllData() {
        /// TODO - Delete all data locally
    }
}
