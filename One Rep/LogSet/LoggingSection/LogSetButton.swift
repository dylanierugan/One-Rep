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
                Text("Log")
                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                Image(systemName: Icons.PencilAndOutline.description)
                    .customFont(size: .caption, weight: .bold, kerning: 0, design: .rounded)
            }
            .foregroundStyle(colorScheme == .light ? .black : .white)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                .linearGradient(colors: [
                    .secondary.opacity(0.05),
                    .secondary.opacity(0.05)
                ], startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(16)
            .foregroundColor(.white)
        }
    }
}
