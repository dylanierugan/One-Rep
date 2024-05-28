//
//  TabHolderView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI
import RealmSwift

struct TabHolderView: View {
    
    @Environment(\.realm) var realm
    
    @ObservedResults(MovementViewModel.self) var movementsCollection
    
    // MARK: - View
    
    var body: some View {
        if let movements = movementsCollection.first {
            TabView() {
                MovementsView(movementViewModel: movements)
                    .tabItem {
                        Image(systemName: Icons.FigureStrengthTraining.description)
                    }
                SettingsView(movementViewModel: movements)
                    .tabItem {
                        Image(systemName: Icons.PersonFill.description)
                    }
            }
            .font(.headline)
            .accentColor(.primary)
        } else {
            ProgressView().onAppear { 
                let movementViewModel = MovementViewModel()
                movementViewModel.ownerId = realm.syncSession?.parentUser()?.id ?? ""
                $movementsCollection.append(movementViewModel)
            }
        }
    }
}
