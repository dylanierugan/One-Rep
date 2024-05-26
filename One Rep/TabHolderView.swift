//
//  TabHolderView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI
import RealmSwift

struct TabHolderView: View {
        
    @EnvironmentObject var app: RealmSwift.App
    
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var movementViewModel: MovementViewModel
    
    // MARK: - View
    
    var body: some View {
        /// Initialize movements
        if let movements = $movementViewModel.first {
            /// TabView holds 2 tabs: Movements and Settings
            TabView() {
                MovementsView()
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
            ProgressView()
                .onAppear {
//                    $movementsCollection.append(MovementViewModel())
//                    
//                    if let user = app.currentUser {
//                        let config = user.flexibleSyncConfiguration() { subscriptions in
//                            if let subscription = subscriptions.first(named: "user_movements") {
//                                return
//                            } else {
//                                subscriptions.append(QuerySubscription<MovementViewModel>(name: "user_movements", query: {
//                                    $0.userID == user.id
//                                }))
//                                subscriptions.append(QuerySubscription<Movement>())
//                                subscriptions.append(QuerySubscription<Log>())
//                            }
//                        }
//                    }
//                    
//                    if let movements = movementsCollection.first {
//                        if let userID = app.currentUser?.id {
//                            movements.userID = userID
//                        } else {
//                            /// Handle error for no ID
//                        }
//                    } else {
//                        /// Handle error for no collection
//                    }
                }
        }
    }
}
