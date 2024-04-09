//
//  TabHolderView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI
import RealmSwift

struct TabHolderView: View {
    
    @ObservedResults(MovementViewModel.self) var movementsCollection
    
    @State var loadingUser = true
    @State var showUserError = false
    @State var loadingMovementData = true
    @State var loadingRoutineData = true
    @State var showLoadDataError = false
    @State var movementsLoading = true
    @State var showMovementLoadingError = true
    @State var movementLoadingErrorMessage = ""
    @State var errorMessage = ""
    
    var body: some View {
        /// TabView holds 2 tabs: Movements and Settings
        if let movements = movementsCollection.first {
            TabView() {
                MovementsView(movementModel: movements)
                    .tabItem {
                        Image(systemName: Icons.FigureStrengthTraining.description)
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: Icons.PersonFill.description)
                    }
            }
            .font(.headline)
            .accentColor(.primary)
        } else {
            ProgressView()
                .onAppear {
                    $movementsCollection.append(MovementViewModel())
                }
        }
    }
    
}
