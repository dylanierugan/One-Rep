//
//  SettingsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI
import RealmSwift

struct SettingsView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var app: RealmSwift.App
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        AccountView()
                        ThemesView()
                        LogOutButton()
                            .padding(.top, 12)
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
