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
    @StateObject private var errorHandler = ErrorHandler()
    @StateObject private var movementsViewModel = MovementsViewModel()
    @StateObject private var logsViewModel = LogsViewModel(unit: UserDefaults.standard.unitSelection)
    @StateObject private var logController = LogController()
    @StateObject private var routinesViewModel = RoutinesViewModel()
    @StateObject private var viewRouter = ViewRouter()
    @StateObject private var themeModel = ThemeModel(accent: ThemeModel.getAccentColor(),
                                                     colorScheme: ThemeModel.getColorScheme())
    @StateObject private var userViewModel = UserViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    // MARK: - Scene
    
    var body: some Scene {
        WindowGroup {
            MotherView()
                .environmentObject(authManager)
                .environmentObject(errorHandler)
                .environmentObject(logController)
                .environmentObject(logsViewModel)
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
