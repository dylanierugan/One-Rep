//
//  SyncRealmContentView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/27/24.
//

import RealmSwift
import SwiftUI

struct SyncRealmView: View {
    
    @EnvironmentObject var app: RealmSwift.App
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var realm: Realm? = nil
    @State private var isLoading = true
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            
            if isLoading {
                OneRepProgressView(text: ProgressText.Loading.description)
            } else if let user = app.currentUser, let realm = realm {
                OpenRealmView(user: user)
                    .environment(\.realm, realm)
            } else {
                OneRepProgressView(text: ProgressText.Loading.description)
                    .onAppear { viewRouter.currentPage = .loginView }
            }
        }
        .onAppear {
            loadRealm()
        }
    }
    
    // MARK: - Helper Function
    
    private func loadRealm() {
        guard let user = app.currentUser else {
            viewRouter.currentPage = .loginView
            return
        }
        
        Task {
            do {
                let loadedRealm = try await setupConfiguration(for: user)
                DispatchQueue.main.async {
                    self.realm = loadedRealm
                    self.isLoading = false
                }
            } catch {
                print("Failed to open realm: \(error.localizedDescription)")
                // Handle error, possibly update the UI to indicate failure
            }
        }
    }
    
    private func setupConfiguration(for user: User) async throws -> Realm {
        var config = user.flexibleSyncConfiguration(initialSubscriptions: { subscriptions in
            
            if let _ = subscriptions.first(named: AppConstants.MovementKey.description) {
                // Subscription already exists, do nothing
            } else {
                subscriptions.append(QuerySubscription<MovementViewModel>(name: AppConstants.MovementKey.description) {
                    $0.ownerId == user.id
                })
                subscriptions.append(QuerySubscription<Movement>())
                subscriptions.append(QuerySubscription<Log>())
            }
            if let _ = subscriptions.first(named: AppConstants.UserKey.description) {
                // Subscription already exists, do nothing
            } else {
                subscriptions.append(QuerySubscription<UserModel>(name: AppConstants.UserKey.description) {
                    $0.ownerId == user.id
                })
                subscriptions.append(QuerySubscription<BodyweightEntry>())
            }
        })
        
//        // Set up the migration block
//        config.schemaVersion = 0 // Increment this whenever you make a schema change
//        config.migrationBlock = { migration, oldSchemaVersion in
//            if oldSchemaVersion < 1 {
//                // Perform migration tasks here
//                migration.enumerateObjects(ofType: Routine.className()) { oldObject, newObject in
//                    // Add the new property and set a default value
//                    newObject?["datesTracked"] = RealmSwift.List<Date>()
//                }
//            }
//        }
        
        let realm = try await Realm(configuration: config, actor: MainActor.shared, downloadBeforeOpen: .always)
        
        return realm
    }
}
