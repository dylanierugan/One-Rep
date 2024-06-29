//
//  SettingsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
   
//    @ObservedRealmObject var movementViewModel: MovementViewModel
//    @ObservedRealmObject var userModel: UserModel
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 16) {
                        AccountSection()
//                        BodyweightSection(userModel: userModel)
//                        UnitSection()
//                        ThemeSection()
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
