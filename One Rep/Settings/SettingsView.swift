//
//  SettingsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var userViewModel: UserViewModel

    // MARK: - View
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 16) {
                        AccountSection()
                        BodyweightSection()
                        ThemeSection()
                        AppearanceSection()
                        UnitSection()
                        HelpSection()
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle(SettingsStrings.Settings.rawValue)
        }
    }
}
