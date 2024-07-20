//
//  AppearanceSection.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/20/24.
//

import SwiftUI

struct AppearanceSection: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(SettingsStrings.Appearance.rawValue)
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary)
            VStack(alignment: .leading) {
                HStack(spacing: 24) {
                    AppearanceButton(appearanceString: SettingsStrings.Dark.rawValue, colorScheme: .dark)
                    AppearanceButton(appearanceString: SettingsStrings.Light.rawValue, colorScheme: .light)
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
            .frame(height: 48)
            .background(Color(theme.backgroundElementColor))
            .cornerRadius(16)
        }
    }
}

struct AppearanceButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var themeColor: ThemeModel
    
    // MARK: - Public Properties
    
    var appearanceString: String
    var colorScheme: ColorScheme
    
    // MARK: - View
    
    var body: some View {
        Button {
            withAnimation {
                UserDefaults.standard.appColorScheme = colorScheme == .dark ? .dark : .light
                themeColor.colorScheme = colorScheme
                HapticManager.instance.impact(style: .soft)
            }
        } label: {
            HStack {
                Text(colorScheme == .dark ? SettingsStrings.Dark.rawValue : SettingsStrings.Light.rawValue)
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
            }
            .frame(width: 44, height: 28)
            .foregroundStyle(colorScheme == themeColor.colorScheme ? Color(.reversePrimary): .secondary)
            .background(colorScheme == themeColor.colorScheme ? Color(.customPrimary) : .clear)
            .cornerRadius(8)
        }
    }
}
