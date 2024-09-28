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
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    @EnvironmentObject var routinesViewModel: RoutinesViewModel
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - View
    
    var body: some View {
        Button {
            Task {
                await logOutUser()
            }
        } label: {
            HStack(spacing: 16) {
                Image(systemName: Icons.RectanglePortraitAndArrowRight.rawValue)
                Text(LogOutStrings.LogOut.rawValue)
                Spacer()
            }
            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
            .foregroundStyle(.primary)
        }
    }
    
    // MARK: - Functions
    
    private func logOutUser() async {
        do {
            try await AuthenticationManager.shared.signOut()
            withAnimation {
                viewRouter.currentPage = .loginView
            }
            clearViewModelData()
        } catch {
            // TODO: Handle error
            print("\(error.localizedDescription)")
        }
    }
    
    private func clearViewModelData() {
        movementsViewModel.clearMovments()
        movementsViewModel.movementsLoading = true
        
        routinesViewModel.unsubscribe()
        routinesViewModel.clearData()
        routinesViewModel.routinesLoading = true
        
        logsViewModel.clearLogs()
        logsViewModel.logsLoading = true
        
        userViewModel.clearLocalBodyweightEntries()
        userViewModel.userLoading = true
        userViewModel.user = nil
        userViewModel.userId = ""
    }
}
