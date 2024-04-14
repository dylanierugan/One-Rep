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
    @StateObject var themeColor = ThemeModel(accent: UserDefaults.standard.string(forKey: DefaultKeys.AccentColor.description) ?? Colors.Green.description)
    
    var body: some Scene {
        WindowGroup {
            MotherView()
                .environment(\.sizeCategory, .extraSmall)
                .environmentObject(app)
                .environmentObject(viewRouter)
                .environmentObject(themeColor)
        }
    }
}
