//
//  One_RepApp.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/15/24.
//

import FirebaseCore
import RevenueCat
import SwiftUI

@main
struct One_RepApp: SwiftUI.App {
    
    // MARK: - StateObjects

    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    @StateObject private var movementsViewModel = MovementsViewModel()
    @StateObject private var logsViewModel = LogsViewModel(unit: UserDefaults.standard.unitSelection)
    @StateObject private var routinesViewModel = RoutinesViewModel()
    @StateObject private var viewRouter = ViewRouter()
    @StateObject private var themeModel = ThemeModel(accent: ThemeModel.getAccentColor(),
                                                     colorScheme: ThemeModel.getColorScheme())
    @StateObject private var userViewModel = UserViewModel()
    
    init() {
        FirebaseApp.configure()
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: RevenueCat.PublicAPIKey.rawValue)
    }
    
    // MARK: - Scene
    
    var body: some Scene {
        WindowGroup {
            MotherView()
                .environmentObject(authenticationViewModel)
                .environmentObject(logsViewModel)
                .environmentObject(movementsViewModel)
                .environmentObject(routinesViewModel)
                .environmentObject(themeModel)
                .environmentObject(viewRouter)
                .environment(\.sizeCategory, .extraSmall)
                .environment(\.colorScheme, themeModel.colorScheme)
                .environmentObject(userViewModel)
        }
    }
}
