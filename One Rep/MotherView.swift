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
        case .main:
            TabHolderView()
        case .login:
            LoginView()
                .onAppear {
                    checkLogIn()
                }
        }
    }
    
    // MARK: - Functions
    
    func checkLogIn() {
        /// Function checks if user is logged in and redirects the user to the appropriate view
        if let _ = app.currentUser?.isLoggedIn {
            viewRouter.currentPage = .main
        } else {
            viewRouter.currentPage = .login
        }
    }
}
