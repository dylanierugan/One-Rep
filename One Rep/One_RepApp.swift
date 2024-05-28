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
    
    // MARK: - StateObject
    
    @StateObject var app: RealmSwift.App
    @StateObject var authService: AuthService
    @StateObject var viewRouter = ViewRouter()
    @StateObject var dateViewModel = DateViewModel()
    @StateObject var logViewModel = LogViewModel()
    @StateObject var logController = LogController()
    @StateObject var themeColor = ThemeModel(accent: UserDefaults.standard.string(forKey: DefaultKeys.AccentColor.description) ?? Colors.LightGreen.description)
    
    init() {
        let app = RealmSwift.App(id: AppConstants.ID.description)
        _app = StateObject(wrappedValue: app)
        _authService =  StateObject(wrappedValue: AuthService(app: app))
    }
    
    // MARK: - Scene
    
    var body: some Scene {
        WindowGroup {
            MotherView()
                .environment(\.sizeCategory, .extraSmall)
                .environmentObject(app)
                .environmentObject(authService)
                .environmentObject(viewRouter)
                .environmentObject(dateViewModel)
                .environmentObject(logViewModel)
                .environmentObject(logController)
                .environmentObject(themeColor)
        }
    }
}
