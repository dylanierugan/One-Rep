//
//  DeleteAccountView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/11/24.
//

import AuthenticationServices
import SwiftUI

struct DeleteAccountView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    @EnvironmentObject var routinesViewModel: RoutinesViewModel
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var viewRouter: ViewRouter
    @Environment(\.colorScheme) private var currentScheme
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            VStack(spacing: 32) {
                Text(DeleteAccountStrings.DeleteAccountInstructions.rawValue)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .customFont(size: .body, weight: .semibold, design: .rounded)
                SignInWithAppleButton(.signIn, onRequest: { request in
                    AppleSignInManager.shared.requestAppleAuthorization(request)
                }, onCompletion: { result in
                    authManager.handleAppleID(result) {
                        callDeleteUser()
                    }
                })
                .signInWithAppleButtonStyle(currentScheme == .light ? .black : .white)
                .cornerRadius(16)
                .frame(height: 32)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 48)
        }
    }
    
    // MARK: - Functions
    
    private func callDeleteUser() {
        Task {
            do {
                try await authManager.deleteUser()
                await deleteAllData()
                withAnimation {
                    viewRouter.currentPage = .loginView
                }
            } catch {
                // TODO: Handle error
            }
        }
    }
    
    private func deleteAllData() async {
        _ = await movementsViewModel.deleteAllUserMovements(userId: userViewModel.userId)
        _ = await routinesViewModel.deleteAllUserRoutines(userId: userViewModel.userId)
        _ = await logsViewModel.deleteAllUserLogs(userId: userViewModel.userId)
        _ = await userViewModel.deleteAllUserBodyweightEntries()
        // TODO: Handle error
    }
}
