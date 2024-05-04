//
//  LogSetButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI
import RealmSwift

struct LogSetButton: View {
    
    // MARK: - Variables
    
    @ObservedRealmObject var movement: Movement
    
    @EnvironmentObject var theme: ThemeModel
    
    var addLogToRealm:() -> Void
    var setMostRecentLog:() -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            addLogToRealm()
            setMostRecentLog()
            HapticManager.instance.impact(style: .soft)
        } label: {
            HStack {
                Text("Log set")
                Image(systemName: Icons.Pencil.description)
            }
            .customFont(size: .caption, weight: .bold, kerning: 0, design: .rounded)
            .foregroundStyle(Color(theme.darkBaseColor))
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color(theme.darkBaseColor).opacity(0.1))
            .cornerRadius(16)
            .foregroundColor(.white)
        }
    }
}
