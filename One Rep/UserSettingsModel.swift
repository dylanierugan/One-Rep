//
//  UserSettingsModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import Foundation

class UserSettingsModel: ObservableObject {
    
    @Published var darkMode: Bool
    @Published var accentColor: String
    
    init() {
        self.darkMode = UserDefaults.standard.bool(forKey: "darkMode")
        self.accentColor = UserDefaults.standard.string(forKey: "accentColor") ?? "logoGreen"
    }
    
}
