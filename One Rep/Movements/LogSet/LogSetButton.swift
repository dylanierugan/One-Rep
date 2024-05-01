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
    
    @Binding var setTypeSelection: RepType
    @Binding var setTypeColorDark: Color
    @Binding var setTypeColorLight: Color
    
    var addLogToRealm:() -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            addLogToRealm()
            HapticManager.instance.impact(style: .light)
        } label: {
            HStack {
                Text("Log \(setTypeSelection.rawValue)")
                    .customFont(size: .caption, weight: .bold, kerning: 0, design: .rounded)
                    .foregroundStyle(
                        .linearGradient(colors:
                                            [Color(setTypeColorLight),
                                             Color(setTypeColorDark)],
                                        startPoint: .top, endPoint: .bottom)
                    )
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color(setTypeColorLight).opacity(0.1))
            .cornerRadius(16)
            .customFont(size: .caption, weight: .medium, kerning: 0, design: .rounded)
            .foregroundColor(.white)
        }
    }
}
