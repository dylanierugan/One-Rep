//
//  ThemesView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/6/24.
//

import SwiftUI

struct ThemesView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Appearance")
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary.opacity(0.5))
            VStack(alignment: .leading) {
                HStack(spacing: 24) {
                    ColorButton(stringColor: Colors.LightGreen.description, darkBase: Colors.LightGreen.description, lightBase: Colors.DarkGreen.description)
                    ColorButton(stringColor: Colors.LightPink.description, darkBase: Colors.DarkPink.description, lightBase: Colors.LightPink.description)
                    Spacer()
                }
                .padding(16)
            }
            .background(Color(theme.BackgroundElementColor))
            .cornerRadius(16)
        }
        .padding(.horizontal, 16)
    }
}

struct ColorButton: View {
    // MARK: - Variables
    
    @EnvironmentObject var themeColor: ThemeModel
    
    var stringColor: String
    var darkBase: String
    var lightBase: String
    
    // MARK: - View
    
    var body: some View {
        Button {
            /// Set choice in defaults
            UserDefaults.standard.set(stringColor, forKey: DefaultKeys.AccentColor.description)
            themeColor.accent = stringColor
            themeColor.changeColor(color: stringColor)
        } label: {
            Rectangle()
                .frame(width: 24, height: 24)
                .cornerRadius(8)
                .foregroundStyle(.linearGradient(colors: [
                    Color(lightBase),
                    Color(darkBase)
                ], startPoint: .topLeading, endPoint: .bottomTrailing))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(themeColor.accent == stringColor ?  .primary : Color.clear, lineWidth: 3)
                )
        }
    }
}