//
//  AccountView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI

struct AccountSection: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var theme: ThemeModel
    
    // @ObservedRealmObject var movementViewModel: MovementViewModel
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Account")
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary)
            NavigationLink {
                AccountView()
            } label: {
                VStack(alignment: .leading) {
                    HStack(spacing: 24) {
                        HStack(spacing: 16) {
                            Image(systemName: Icons.PersonFill.rawValue)
                            Text(authManager.user?.email ?? "No user")
                        }
                        .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                        Spacer()
                        Image(systemName: Icons.ChevronRight.rawValue)
                            .font(.caption).bold()
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 16)
                }
                .frame(height: 48)
                .background(Color(theme.backgroundElementColor))
                .cornerRadius(16)
            }
        }
    }
}
