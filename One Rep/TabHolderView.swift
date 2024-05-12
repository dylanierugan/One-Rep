//
//  TabHolderView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI
import RealmSwift

struct TabHolderView: View {
    
    // MARK: - ObservedResults
    
    @ObservedResults(MovementViewModel.self) var movementsCollection
    
    // MARK: - View
    
    var body: some View {
        /// Initialize movements
        if let movements = movementsCollection.first {
            /// TabView holds 2 tabs: Movements and Settings
            TabView() {
                MovementsListView(movementModel: movements)
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
