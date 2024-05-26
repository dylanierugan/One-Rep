//
//  One_RepApp.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/15/24.
//

import SwiftUI
import RealmSwift

@main
struct One_RepApp: SwiftUI.App {
    
    @StateObject var app = RealmSwift.App(id: App.ID.description)
    @StateObject var authService = AuthService()
    @StateObject var viewRouter = ViewRouter()
    @StateObject var movementViewModel = MovementViewModel()
    @StateObject var logViewModel = LogViewModel()
    @StateObject var logController = LogController()
    @StateObject var dateViewModel = DateViewModel()
    @StateObject var themeColor = ThemeModel(accent: UserDefaults.standard.string(forKey: DefaultKeys.AccentColor.description) ?? Colors.LightGreen.description)
    
    // MARK: - Scene
    
    var body: some Scene {
        WindowGroup {
            MotherView()
                .environment(\.sizeCategory, .extraSmall)
                .environmentObject(app)
                .environmentObject(authService)
                .environmentObject(viewRouter)
                .environmentObject(movementViewModel)
                .environmentObject(logViewModel)
                .environmentObject(logController)
                .environmentObject(dateViewModel)
                .environmentObject(themeColor)
        }
    }
}
