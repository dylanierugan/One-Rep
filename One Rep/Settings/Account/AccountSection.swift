//
//  AccountView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI

struct AccountSection: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(SettingsStrings.Account.rawValue)
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary)
            NavigationLink {
                AccountView()
            } label: {
                VStack(alignment: .leading) {
                    HStack(spacing: 24) {
                        HStack(spacing: 16) {
                            Image(systemName: Icons.PersonFill.rawValue)
                            if AuthenticationManager.shared.user?.isAnonymous == true {
                                Text(SettingsStrings.Anonymous.rawValue)
                            } else {
                                Text(userViewModel.user?.email ?? SettingsStrings.NoUser.rawValue)
                            }
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
