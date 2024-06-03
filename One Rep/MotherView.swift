//
//  MotherView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI

import SwiftUI
import Realm
import RealmSwift

/// View holds either login/signup or tabview
struct MotherView: View {
    
    @EnvironmentObject var app: RealmSwift.App
    @EnvironmentObject var viewRouter: ViewRouter
    
    // MARK: - View
    
    var body: some View {
        switch viewRouter.currentPage {
        case .loginView:
            LoginView()
        case .syncRealm:
            SyncRealmView()
        case .tabView:
            if let realm = viewRouter.realm {
                TabHolderView()
                    .environment(\.realm, realm)
            } else {
                LoginView()
            }
        }
    }
}
