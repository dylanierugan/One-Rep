//
//  AccountView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/24/24.
//

import SwiftUI

struct AccountView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 16) {
                        Image(systemName: Icons.PersonFill.rawValue)
                        Text(authManager.user?.email ?? "No user")
                    }
                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                    Divider()
                        .padding(.leading, 32)
                    LogOutButton()
                    Divider()
                        .padding(.leading, 32)
                    DeleteAccountButton()
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
