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
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    
    // MARK: - Private Properties
    
    @State private var movementsLoading = true
    @State private var logsLoading = true
    
    // MARK: - View
    
    var body: some View {
        VStack {
            if movementsLoading || logsLoading {
                OneRepProgressView(text: ProgressText.OneRep.rawValue)
                    .onAppear() {
                        if let user = Auth.auth().currentUser {
                            getMovements(userId: user.uid)
                            getLogs(userId: user.uid)
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
    
    private func getMovements(userId: String) {
        if movementsViewModel.movements.isEmpty {
            movementsViewModel.userId = userId
            movementsViewModel.subscribeToMovements { result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        movementsLoading = false
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    /// TODO - Error handle
                }
            }
        }
    }
    
    private func getLogs(userId: String) {
        if logViewModel.logs.isEmpty {
            logViewModel.userId = userId
            logViewModel.getLogsAddSnapshot { result in
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
}