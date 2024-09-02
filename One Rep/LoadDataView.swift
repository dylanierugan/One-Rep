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
                logsViewModel.logsLoading ||
                routinesViewModel.routinesLoading {
                OneRepProgressView(text: ProgressText.OneRep.rawValue).onAppear {
                        if let user = Auth.auth().currentUser {
                            loadAllData()
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
    
    private func loadAllData() {
        let group = DispatchGroup()
        
        if let user = Auth.auth().currentUser {
            group.enter()
            gerUser(userId: user.uid)
            group.leave()
            
            group.enter()
            getMovements()
            group.leave()
            
            group.enter()
            getLogs()
            group.leave()
            
            group.enter()
            getRoutines()
            group.leave()
        }
        
        group.notify(queue: .main) {
            withAnimation {
                viewRouter.currentPage = .tabView
            }
        }
    }
    
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
    
    private func getRoutines() {
        if routinesViewModel.routines.isEmpty {
            routinesViewModel.subscribeToRoutines(userId: userViewModel.userId)
        }
    }
}
