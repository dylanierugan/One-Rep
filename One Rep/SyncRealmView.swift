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
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            if let user = app.currentUser {
                let config = user.flexibleSyncConfiguration(initialSubscriptions: { subscriptions in
                    if let _ = subscriptions.first(named: AppConstants.MovementKey.description) {
                        return
                    } else {
                        subscriptions.append(QuerySubscription<MovementViewModel>(name: AppConstants.MovementKey.description) {
                            $0.ownerId == user.id
                        })
                        subscriptions.append(QuerySubscription<Movement>())
                        subscriptions.append(QuerySubscription<Log>())
                        subscriptions.append(QuerySubscription<UserModel>(name: AppConstants.UserKey.description) {
                            $0.ownerId == user.id
                        })
                    }
                })
                OpenRealmView(user: user)
                    .environment(\.realmConfiguration, config)
            } else {
                OneRepProgressView(text: ProgressText.Loading.description)
                    .onAppear() { viewRouter.currentPage = .loginView }
            }
        }
    }
}
