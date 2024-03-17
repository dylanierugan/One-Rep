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
    
    // MARK: - View Router Logic
    
    var body: some View {
        switch viewRouter.currentPage {
        case .main:
            TabHolderView()
                .dynamicTypeSize(.xSmall)
        case .login:
            LoginView()
                .onAppear {
                    checkLogIn()
                }
                .dynamicTypeSize(.xSmall)
        }
    }
    
    // MARK: - Functions
    
    /// Function checks if user is logged in and redirects the user to the appropriate view
    func checkLogIn() {
        if app.currentUser != nil {
            viewRouter.currentPage = .main
        } else {
            viewRouter.currentPage = .login
        }
    }
}
