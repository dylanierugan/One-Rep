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
    @ObservedResults(RoutineViewModel.self) var routinesCollection
    
    // MARK: - View
    
    var body: some View {
        /// Initialize movements
        if let movements = movementsCollection.first {
            /// TabView holds 2 tabs: Movements and Settings
            TabView() {
                MovementsView(movementViewModel: movements)
                    .tabItem {
                        Image(systemName: Icons.FigureStrengthTraining.description)
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: Icons.PersonFill.description)
                    }
                if let routines = routinesCollection.first {
                    Demo(routineViewModel: routines, movementViewModel: movements)
                        .tabItem {
                            Image(systemName: Icons.ChartXYAxis.description)
                        }
                }
            }
            .font(.headline)
            .accentColor(.primary)
            .onAppear {
                $routinesCollection.append(RoutineViewModel())
            }
        } else {
            ProgressView()
                .onAppear {
                    $movementsCollection.append(MovementViewModel())
                }
        }
    }
}
