//
//  DeleteAccountNavLink.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/24/24.
//

import SwiftUI
import FirebaseAuth

struct DeleteAccountNavLink: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    // MARK: - View
    
    var body: some View {
        NavigationLink {
            DeleteAccountView()
        } label: {
            HStack(spacing: 16) {
                Image(systemName: Icons.Trash.rawValue)
                Text(DeleteAccountStrings.DeleteAccount.rawValue)
            }
            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
            .foregroundStyle(.primary)
        }
    }
}
