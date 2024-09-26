//
//  LoadDataView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/28/24.
//

import Firebase
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
                logsViewModel.logsLoading {
                //                logsViewModel.logsLoading ||
                //                routinesViewModel.routinesLoading {
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
        } catch {
            // TODO: Handle error - got back to login
        }
    }
    
    private func loadAllData() async {
        setUserViewModelUserId()
        await loadUser()
        await loadMovements()
        await loadLogs()
    }
    
    private func loadUser() async {
        try? await userViewModel.loadCurrentUser()
        try? await userViewModel.loadBodyweightEntries()
    }
    
    private func loadMovements() async {
        if movementsViewModel.movements.isEmpty {
            try? await movementsViewModel.loadMovements(userId: userViewModel.userId)
        }
    }
    
    private func loadLogs() async {
        if logsViewModel.logs.isEmpty {
            try? await logsViewModel.loadLogs(userId: userViewModel.userId, movements: movementsViewModel.movements)
        }
    }
    //
    //    private func getRoutines() {
    //        if routinesViewModel.routines.isEmpty {
    //            routinesViewModel.subscribeToRoutines(userId: userViewModel.userId)
    //        }
    //    }
}
