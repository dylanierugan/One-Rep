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
                Color(theme.BackgroundColor)
                    .ignoresSafeArea()
                
                ScrollView {
                    ThemesView()
                    Text(app.currentUser?.profile.email ?? "No user")
                    Button {
                        app.currentUser?.logOut { (error) in
                            if error != nil {
                                
                            } else {
                                DispatchQueue.main.async {
                                    withAnimation {
                                        viewRouter.currentPage = .login
                                    }
                                }
                            }
                        }
                    } label: {
                        Text("Log Out")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
