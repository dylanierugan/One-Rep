//
//  DeleteAccountButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/24/24.
//

import SwiftUI
import FirebaseAuth

struct DeleteAccountButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    @EnvironmentObject var routinesViewModel: RoutinesViewModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - Global Properties
    
    @State private var showDeleteMovementAlert = false
    
    // MARK: - View
    
    var body: some View {
        Button {
            showDeleteMovementAlert = true
        } label: {
            HStack(spacing: 16) {
                Image(systemName: Icons.Trash.rawValue)
                Text(DeleteAccountStrings.DeleteAccount.rawValue)
                Spacer()
            }
            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
            .foregroundStyle(.linearGradient(colors: [
                Color(theme.lightRed),
                Color(theme.darkRed)
            ], startPoint: .top, endPoint: .bottom))
        }
        .alert(isPresented: $showDeleteMovementAlert) {
            Alert(
                title: Text(DeleteAccountStrings.DeleteAccountConfirmation.rawValue),
                message: Text(DeleteAccountStrings.NoWayToUndo.rawValue),
                primaryButton: .destructive(Text(DeleteAccountStrings.Delete.rawValue)) {
                    deleteUser()
                },
                secondaryButton: .cancel())
        }
    }
    
    // MARK: - Function
    
    private func deleteUser() {
        Task {
            do {
                try await authManager.deleteUser()
                await deleteAllData()
                withAnimation {
                    viewRouter.currentPage = .loginView
                }
            } catch {
                /// Todo - Handle error
            } 
        }
    }
    
    private func deleteAllData() async {
        let deleteMovementResults = await movementsViewModel.deleteAllUserMovements()
        let deleteRoutineResults = await routinesViewModel.deleteAllUserRoutines()
        let deleteLogResults = await logViewModel.deleteAllUserLogs()
        let deleteBodyweightResults = await userViewModel.deleteAllUserBodyweightEntries()
        /// TODO - Handle errors
    }
}
