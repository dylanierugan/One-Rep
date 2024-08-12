//
//  LogOutButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI

struct LogOutButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    @EnvironmentObject var routinesViewModel: RoutinesViewModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - View
    
    var body: some View {
        Button {
            logOutUser()
        } label: {
            HStack(spacing: 16) {
                Image(systemName: Icons.RectanglePortraitAndArrowRight.rawValue)
                Text(LogOutStrings.LogOut.rawValue)
                Spacer()
            }
            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
            .foregroundStyle(.linearGradient(colors: [
                Color(theme.lightBaseColor),
                Color(theme.darkBaseColor)
            ], startPoint: .top, endPoint: .bottom))
        }
    }
    
    // MARK: - Functions
    
    private func logOutUser() {
        Task {
            do {
                try await authManager.signOut()
                withAnimation {
                    viewRouter.currentPage = .loginView
                }
                movementsViewModel.unsubscribe()
                movementsViewModel.clearData()
                routinesViewModel.unsubscribe()
                routinesViewModel.clearData()
                logViewModel.unsubscribe()
                logViewModel.clearData()
                userViewModel.unsubscribe()
                userViewModel.clearData()
            } catch {
                /// TODO - Handle error
                print("\(error.localizedDescription)")
            }
        }
    }
}
