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

    @StateObject private var authManager = AuthManager()
    @StateObject private var dateViewModel = DateViewModel()
    @StateObject private var errorHandler = ErrorHandler()
    @StateObject private var movementsViewModel = MovementsViewModel()
    @StateObject private var logViewModel = LogViewModel(unit: UserDefaults.standard.unitSelection)
    @StateObject private var logController = LogController()
    @StateObject private var routinesViewModel = RoutinesViewModel()
    @StateObject private var viewRouter = ViewRouter()
    @StateObject private var themeModel = ThemeModel(accent: UserDefaults.standard.string(forKey: DefaultKeys.AccentColor.rawValue) ?? Colors.LightGreen.rawValue, colorScheme: UserDefaults.standard.appColorScheme == .dark ? .dark : .light)
    @StateObject private var userViewModel = UserViewModel()
    
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
                .environmentObject(dateViewModel)
                .environmentObject(errorHandler)
                .environmentObject(logController)
                .environmentObject(logViewModel)
                .environmentObject(movementsViewModel)
                .environmentObject(routinesViewModel)
                .environmentObject(themeModel)
                .environmentObject(viewRouter)
                .environmentObject(userViewModel)
                .environment(\.sizeCategory, .extraSmall)
                .environment(\.colorScheme, themeModel.colorScheme)
        }
    }
}
