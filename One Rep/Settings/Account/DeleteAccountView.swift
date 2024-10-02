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
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
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
                Button {
                    Task {
                        do {
                            _ = try await authenticationViewModel.signInWithApple()
                            Task {
                                await deleteUser()
                            }
                        } catch {
                            // TODO: Handle error
                        }
                    }
                } label: {
                    SignInWithAppleButtonViewRepresentable(type: .default, style: currentScheme == .light ? .black : .white)
                        .allowsHitTesting(false)
                        .frame(height: 32)
                        .cornerRadius(16)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 48)
        }
    }
    
    // MARK: - Functions
    
    private func deleteUser() async {
        do {
            try await AuthenticationManager.shared.deleteUser()
            await deleteAllData(userId: userViewModel.userId)
            clearData()
            withAnimation {
                viewRouter.currentPage = .loginView
            }
        } catch {
            // TODO: Handle error
        }
    }
    
    private func deleteAllData(userId: String) async {
        await logsViewModel.deleteAllUserLogs(userId: userId, movements: movementsViewModel.movements)
        await movementsViewModel.deleteAllMovements(userId: userId)
        // _ = await routinesViewModel.deleteAllUserRoutines(userId: userViewModel.userId)
        await userViewModel.deleteAllBodyweightEntries()
        await userViewModel.deleteUser()
    }
    
    private func clearData() {
        movementsViewModel.clearMovments()
        movementsViewModel.movementsLoading = true
        
        routinesViewModel.clearRoutines()
        routinesViewModel.routinesLoading = true
        
        logsViewModel.clearLogs()
        logsViewModel.logsLoading = true
        
        userViewModel.clearLocalBodyweightEntries()
        userViewModel.userLoading = true
    }
}
