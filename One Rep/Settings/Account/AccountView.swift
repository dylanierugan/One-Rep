//
//  AccountView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/24/24.
//

import SwiftUI
import RealmSwift

struct AccountView: View {
    
    @EnvironmentObject var app: RealmSwift.App
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var theme: ThemeModel
    
    @ObservedRealmObject var movementViewModel: MovementViewModel
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 16) {
                        Image(systemName: Icons.PersonFill.description)
                        Text(app.currentUser?.profile.email ?? "No user")
                    }
                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                    Divider()
                        .padding(.leading, 32)
                    LogOutButton(app: app)
                    Divider()
                        .padding(.leading, 32)
                    DeleteAccountButton(app: app, movementViewModel: movementViewModel)
                }
                .padding(16)
                .background(Color(theme.backgroundElementColor))
                .cornerRadius(16)
                .padding(.horizontal, 16)
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Account")
                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                    .foregroundStyle(.primary)
            }
        }
    }
}
