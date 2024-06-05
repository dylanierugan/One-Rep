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
    @EnvironmentObject var theme: ThemeModel
    
    @ObservedRealmObject var movementViewModel: MovementViewModel
    @ObservedRealmObject var userModel: UserModel
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 16) {
                        AccountSection(movementViewModel: movementViewModel)
                        BodyweightSection(userModel: userModel)
                        UnitSection()
                        ThemeSection()
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
