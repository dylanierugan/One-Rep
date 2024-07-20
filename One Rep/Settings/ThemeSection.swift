//
//  ThemesView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/6/24.
//

import SwiftUI

struct ThemeSection: View {
    
    // MARK: - Global Variables
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(SettingsStrings.Theme.rawValue)
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary)
            VStack(alignment: .leading) {
                HStack(spacing: 24) {
                    ColorButton(stringColor: Colors.LightGreen.rawValue, darkBase: Colors.LightGreen.rawValue, lightBase: Colors.DarkGreen.rawValue)
                    ColorButton(stringColor: Colors.LightPink.rawValue, darkBase: Colors.DarkPink.rawValue, lightBase: Colors.LightPink.rawValue)
                    ColorButton(stringColor: Colors.Primary.rawValue, darkBase: Colors.Primary.rawValue, lightBase: Colors.Primary.rawValue)
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

struct ColorButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var themeColor: ThemeModel
    
    // MARK: - Public Properties
    
    var stringColor: String
    var darkBase: String
    var lightBase: String
    
    // MARK: - View
    
    var body: some View {
        Button {
            /// Set choice in defaults
            UserDefaults.standard.set(stringColor, forKey: DefaultKeys.AccentColor.rawValue)
            themeColor.accent = stringColor
            themeColor.changeColor(color: stringColor)
            HapticManager.instance.impact(style: .soft)
        } label: {
            Rectangle()
                .frame(width: 24, height: 24)
                .cornerRadius(8)
                .foregroundStyle(.linearGradient(colors: [
                    Color(lightBase),
                    Color(darkBase)
                ], startPoint: .top, endPoint: .bottom))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(themeColor.accent == stringColor ?  .primary : Color.clear, lineWidth: 3)
                )
        }
    }
}
