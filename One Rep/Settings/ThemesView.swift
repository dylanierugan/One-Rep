//
//  ThemesView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/6/24.
//

import SwiftUI

struct ThemesView: View {
    
    @EnvironmentObject var themeColor: ThemeColorModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Appearance")
                .customFont(size: .caption, weight: .regular, kerning: 1, design: .rounded)
                .foregroundColor(.secondary.opacity(0.5))
            VStack(alignment: .leading) {
                HStack(spacing: 24) {
                    ColorButton(stringColor: Colors.Green.description, base: Colors.GreenBase.description, baseLight: Colors.GreenNeon.description, baseDark: Colors.GreenCyan.description)
                    ColorButton(stringColor: Colors.Pink.description, base: Colors.PinkBase.description, baseLight: Colors.PinkLight.description, baseDark: Colors.PinkPurple.description)
                    Spacer()
                }
                .padding(16)
            }
            .background(Color(themeColor.BackgroundElement))
            .cornerRadius(16)
        }
        .padding(.horizontal, 16)
    }
}

struct ColorButton: View {
    
    @EnvironmentObject var themeColor: ThemeColorModel
    var stringColor: String
    var base: String
    var baseLight: String
    var baseDark: String
    
    var body: some View {
        Button {
            // Set choice in defaults
            UserDefaults.standard.set(stringColor, forKey: DefaultKeys.AccentColor.description)
            themeColor.accent = stringColor
            themeColor.changeColor(color: stringColor)
        } label: {
            Rectangle()
                .frame(width: 24, height: 24)
                .cornerRadius(8)
                .foregroundStyle(.linearGradient(colors: [
                    Color(base),
                    Color(baseLight),
                    Color(baseDark)
                ], startPoint: .topLeading, endPoint: .bottomTrailing))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(themeColor.accent == stringColor ? Color(.white) : Color.clear, lineWidth: 3)
                )
        }
    }
}
