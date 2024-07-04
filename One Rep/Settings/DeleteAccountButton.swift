//
//  DeleteAccountButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/24/24.
//

import SwiftUI

struct DeleteAccountButton: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var viewRouter: ViewRouter
    
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
//                    authService.deleteUser { result in
//                        switch result {
//                        case .failure(let error):
//                            /// Handle error
//                            print("Delete user failed: \(error.localizedDescription)")
//                        case .success:
//                            withAnimation {
//                                deleteAllData()
//                                viewRouter.currentPage = .loginView
//                            }
//                        }
//                    }
                },
                secondaryButton: .cancel())
        }
    }
    
    // MARK: - Function
    
    private func deleteAllData() {
        /// TODO - Delete all data locally
    }
}
