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
    
    // MARK: - Private Properties
    @State private var movementsLoading = true
    @State private var logsLoading = true
    @State private var routinesLoading = true
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            if userViewModel.userLoading || movementsViewModel.movementsLoading || logsLoading || routinesLoading {
                OneRepProgressView(text: ProgressText.OneRep.rawValue)
                    .onAppear() {
                        if let user = Auth.auth().currentUser {
                            gerUser(userId: user.uid)
                            getMovements()
                            getLogs(userId: user.uid)
                            getRoutines(userId: user.uid)
                        }
                    }
            } else {
                OneRepProgressView(text: ProgressText.OneRep.rawValue)
                    .onAppear() {
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
    
    private func getLogs(userId: String) {
        if logsViewModel.logs.isEmpty {
            logsViewModel.userId = userId
            logsViewModel.getLogsAddSnapshot { result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        logsLoading = false
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    /// TODO - Error handle
                }
            }
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
