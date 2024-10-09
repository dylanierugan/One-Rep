//
//  LoadDataView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/28/24.
//

import Firebase
import RevenueCat
import SwiftUI

struct LoadDataView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    @EnvironmentObject var routinesViewModel: RoutinesViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            if userViewModel.userLoading ||
                movementsViewModel.movementsLoading ||
                logsViewModel.logsLoading ||
                routinesViewModel.routinesLoading {
                OneRepProgressView(text: ProgressText.OneRep.rawValue)
                    .task { await loadAllData() }
                    .environmentObject(userViewModel)
            } else {
                OneRepProgressView(text: ProgressText.OneRep.rawValue)
                    .onAppear {
                        withAnimation {
                            viewRouter.currentPage = .tabView
                        }
                    }
                    .environmentObject(userViewModel)
            }
        }
    }
    
    // MARK: - Functions
    
    private func setUserViewModelUserId() {
        do {
            let userId = try AuthenticationManager.shared.getAuthenticatedUser().uid
            userViewModel.userId = userId
            Purchases.shared.logIn(userId) { (customerInfo, created, error) in
                // TODO: Handle error
            }
        } catch {
            // TODO: Handle error - got back to login
        }
    }
    
    private func loadAllData() async {
        setUserViewModelUserId()
        await loadUser()
        await loadMovements()
        await loadLogs()
        await loadRoutines()
    }
    
    private func loadUser() async {
        await userViewModel.loadCurrentUser()
        await userViewModel.loadBodyweightEntries()
    }
    
    private func loadMovements() async {
        if movementsViewModel.movements.isEmpty {
            await movementsViewModel.loadMovements(userId: userViewModel.userId)
        } else {
            movementsViewModel.movementsLoading = false
        }
    }
    
    private func loadLogs() async {
        if logsViewModel.logs.isEmpty {
            await logsViewModel.loadLogs(userId: userViewModel.userId, movements: movementsViewModel.movements)
        } else {
            logsViewModel.logsLoading = false
        }
    }
    
    private func loadRoutines() async {
        if routinesViewModel.routines.isEmpty {
            await routinesViewModel.loadRoutines(userId: userViewModel.userId)
        } else {
            routinesViewModel.routinesLoading = false
        }
    }
}
