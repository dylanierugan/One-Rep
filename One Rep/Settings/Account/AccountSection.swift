//
//  AccountView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI
import RealmSwift

struct AccountSection: View {
    
    @EnvironmentObject var app: RealmSwift.App
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var theme: ThemeModel
    
    @ObservedRealmObject var movementViewModel: MovementViewModel
    
    // MARK: - View
    
    var body: some View {
        NavigationLink {
            AccountView(movementViewModel: movementViewModel)
        } label: {
            VStack(alignment: .leading) {
                Text("Account")
                    .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                    .foregroundColor(.secondary)
                VStack(alignment: .leading) {
                    HStack(spacing: 24) {
                        HStack(spacing: 16) {
                            Image(systemName: Icons.PersonFill.description)
                            Text(app.currentUser?.profile.email ?? "No user")
                        }
                        .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                        Spacer()
                        Image(systemName: Icons.ChevronRight.description)
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
