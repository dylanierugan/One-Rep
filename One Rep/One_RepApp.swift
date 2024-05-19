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
    
    @StateObject var app = RealmSwift.App(id: "one-rep-hpeel")
    @StateObject var viewRouter = ViewRouter()
    @StateObject var dateViewModel = DateViewModel()
    @StateObject var logDataController = LogDataController()
    @StateObject var themeColor = ThemeModel(accent: UserDefaults.standard.string(forKey: DefaultKeys.AccentColor.description) ?? Colors.LightGreen.description)
    
    // MARK: - Scene
    
    var body: some Scene {
        WindowGroup {
            MotherView()
                .environment(\.sizeCategory, .extraSmall)
                .environmentObject(app)
                .environmentObject(viewRouter)
                .environmentObject(dateViewModel)
                .environmentObject(logDataController)
                .environmentObject(themeColor)
        }
    }
}
