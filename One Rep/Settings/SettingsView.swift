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
                        UnitSection()
                        ThemeSection()
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle(SettingsStrings.Settings.rawValue)
        }
    }
}
