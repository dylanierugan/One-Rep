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
    
    @StateObject var app = RealmSwift.App(id: "one-rep-hpeel")
    @StateObject var viewRouter = ViewRouter()
    @StateObject var userSettingsModel = UserSettingsModel()
    
    var body: some Scene {
        WindowGroup {
            MotherView()
                .environmentObject(app)
                .environmentObject(viewRouter)
                .environmentObject(userSettingsModel)
                .task {
                    userSettingsModel.darkMode = UserDefaults.standard.bool(forKey: "darkMode")
                    userSettingsModel.accentColor = UserDefaults.standard.string(forKey: "accentColor") ?? "logoGreen"
                }
        }
    }
}
