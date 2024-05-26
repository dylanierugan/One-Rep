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
    @EnvironmentObject var authService: AuthService
    
    // MARK: - View Router Logic
    
    var body: some View {
        switch viewRouter.currentPage {
        case .loginView:
            LoginView().onAppear { checkLogIn() }
        case .tabView:
            TabHolderView()
        }
    }
    
    // MARK: - Functions
    
    func checkLogIn() {
        if authService.isUserLoggedIn {
            viewRouter.currentPage = .tabView
        } else {
            viewRouter.currentPage = .loginView
        }
    }
}
