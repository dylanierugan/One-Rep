//
//  LogSetButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI
import RealmSwift

struct LogSetButton: View {
    
    @EnvironmentObject var theme: ThemeModel
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedRealmObject var movement: Movement
    
    var addLogToRealm:() -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            addLogToRealm()
            HapticManager.instance.impact(style: .light)
        } label: {
            HStack {
                Text("Log set")
                Image(systemName: Icons.Pencil.description)
            }
            .customFont(size: .caption, weight: .bold, kerning: 0, design: .rounded)
            .foregroundStyle(colorScheme == .dark ? Color(theme.lightBaseColor) : Color(theme.darkBaseColor))
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                .linearGradient(colors: [
                    Color(theme.lightBaseColor).opacity(0.15),
                    Color(theme.darkBaseColor).opacity(0.15)
                ], startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(16)
            .foregroundColor(.white)
        }
    }
}