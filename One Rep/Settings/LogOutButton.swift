//
//  LogOutButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI

struct LogOutButton: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var viewRouter: ViewRouter
    
    // MARK: - View
    
    var body: some View {
        Button {
            Task {
                do {
                    try await authManager.signOut()
                    viewRouter.currentPage = .loginView
                    print("User signed out successfully.")
                } catch {
                    print("Failed to sign out: \(error.localizedDescription)")
                }
            }
        } label: {
            HStack(spacing: 16) {
                Image(systemName: Icons.RectanglePortraitAndArrowRight.rawValue)
                Text("Log Out")
                Spacer()
            }
            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
            .foregroundStyle(.linearGradient(colors: [
                Color(theme.lightBaseColor),
                Color(theme.darkBaseColor)
            ], startPoint: .top, endPoint: .bottom))
        }
    }
}
