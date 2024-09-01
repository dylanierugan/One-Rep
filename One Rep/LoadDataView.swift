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

    @State private var routinesLoading = true
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            if userViewModel.userLoading ||
                movementsViewModel.movementsLoading ||
                logsViewModel.logsLoading ||
                routinesLoading {
                OneRepProgressView(text: ProgressText.OneRep.rawValue)
                    .onAppear {
                        if let user = Auth.auth().currentUser {
                            gerUser(userId: user.uid)
                            getMovements()
                            getLogs()
                            getRoutines(userId: user.uid)
                        }
                    }
            } else {
                OneRepProgressView(text: ProgressText.OneRep.rawValue)
                    .onAppear {
                        withAnimation {
                            viewRouter.currentPage = .tabView
                        }
                    }
            }
        }
    }
    
    // MARK: - Functions
    
    private func gerUser(userId: String) {
        if userViewModel.bodyweightEntries.isEmpty {
            userViewModel.userId = userId
            userViewModel.subscribeToUser()
        }
    }
    
    private func getMovements() {
        if movementsViewModel.movements.isEmpty {
            movementsViewModel.subscribeToMovements(userId: userViewModel.userId)
        }
    }
    
    private func getLogs() {
        if logsViewModel.logs.isEmpty {
            logsViewModel.getLogsAddSnapshot(userId: userViewModel.userId)
        }
    }
    
    private func getRoutines(userId: String) {
        if routinesViewModel.routines.isEmpty {
            routinesViewModel.userId = userId
            routinesViewModel.subscribeToRoutines { result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        routinesLoading = false
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    /// TODO - Error handle
                }
            }
        }
    }
}
