//
//  AccountView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/24/24.
//

import SwiftUI

struct AccountView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    DeleteAccountNavLink()
                        Divider()
                            .padding(.leading, 32)
                    LogOutButton()
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
                Text(SettingsStrings.Account.rawValue)
                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                    .foregroundStyle(.primary)
            }
        }
    }
}
