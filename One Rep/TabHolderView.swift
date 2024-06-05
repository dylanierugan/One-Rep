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
    @ObservedResults(UserModel.self) var userCollection
    
    // MARK: - View
    
    var body: some View {
        if let movements = movementsCollection.first {
            if let userModel = userCollection.first {
                TabView() {
                    MovementsView(movementViewModel: movements, userModel: userModel)
                        .tabItem {
                            Image(systemName: Icons.FigureStrengthTraining.description)
                        }
                    SettingsView(movementViewModel: movements, userModel: userModel)
                        .tabItem {
                            Image(systemName: Icons.PersonFill.description)
                        }
                }
                .font(.headline)
                .accentColor(.primary)
            } else {
                ProgressView().onAppear {
                    let userModel = UserModel()
                    userModel.ownerId = realm.syncSession?.parentUser()?.id ?? ""
                    $userCollection.append(userModel)
                }
            }
        } else {
            ProgressView().onAppear { 
                let movementViewModel = MovementViewModel()
                movementViewModel.ownerId = realm.syncSession?.parentUser()?.id ?? ""
                $movementsCollection.append(movementViewModel)
            }
        }
    }
}
