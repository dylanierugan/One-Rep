//
//  One_RepApp.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/15/24.
//

import FirebaseCore
import SwiftUI

@main
struct One_RepApp: SwiftUI.App {
    
    // MARK: - StateObjects

    @StateObject var authManager = AuthManager()
    @StateObject var errorHandler = ErrorHandler()
    @StateObject var movementsViewModel = MovementsViewModel()
    @StateObject var logViewModel = LogViewModel()
    @StateObject var logController = LogController()
    @StateObject var viewRouter = ViewRouter()
    @StateObject var themeModel = ThemeModel(accent: UserDefaults.standard.string(forKey: DefaultKeys.AccentColor.rawValue) ?? Colors.LightGreen.rawValue)
    @StateObject var userViewModel = UserViewModel()
    
    init() {
        FirebaseApp.configure()
        let authManager = AuthManager()
        _authManager = StateObject(wrappedValue: authManager)
    }
    
    // MARK: - Scene
    
    var body: some Scene {
        WindowGroup {
            MotherView()
                .environmentObject(authManager)
                .environmentObject(errorHandler)
                .environmentObject(logController)
                .environmentObject(logViewModel)
                .environmentObject(movementsViewModel)
                .environmentObject(themeModel)
                .environmentObject(viewRouter)
                .environmentObject(userViewModel)
                .environment(\.sizeCategory, .extraSmall)
        }
    }
}
