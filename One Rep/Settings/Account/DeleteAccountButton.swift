//
//  DeleteAccountButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/24/24.
//

import SwiftUI
import RealmSwift

struct DeleteAccountButton: View {
    
    @ObservedObject var app: RealmSwift.App
    
    @Environment(\.realm) var realm
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    @ObservedRealmObject var movementViewModel: MovementViewModel
    
    @State private var showDeleteMovementAlert = false
    
    // MARK: - View
    
    var body: some View {
        Button {
            showDeleteMovementAlert = true
        } label: {
            HStack(spacing: 16) {
                Image(systemName: Icons.Trash.description)
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
                    authService.deleteUser(app: app) { result in
                        switch result {
                        case .failure(let error):
                            /// Handle error
                            print("Delete user failed: \(error.localizedDescription)")
                        case .success:
                            withAnimation {
                                deleteAllData()
                                viewRouter.currentPage = .loginView
                            }
                        }
                    }
                },
                secondaryButton: .cancel())
        }
    }
    
    // MARK: - Function
    
    private func deleteAllData() {
        for movement in movementViewModel.movements {
            if let thawedMovement = movement.thaw() {
                do {
                    try realm.write {
                        realm.delete(thawedMovement.logs)
                        realm.delete(thawedMovement)
                    }
                } catch  {
                    /// Handle error
                }
            }
        }
    }
}
