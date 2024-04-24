//
//  SetTypeButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct SetTypeButton: View {
    
    // MARK: - Variables
    
    @Binding var setTypeSelection: String
    @Binding var setTypeColorDark: Color
    @Binding var setTypeColorLight: Color
    
    var darkColor: Color
    var lightColor: Color
    var icon: String
    var iconFilled: String
    var setType: String
    
    // MARK: - View
    
    var body: some View {
        Button {
            withAnimation {
                setTypeSelection = setType
                setTypeColorDark = darkColor
                setTypeColorLight = lightColor
            }
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(setType == setTypeSelection ? lightColor.opacity(0.1) : .secondary.opacity(0.05))
                    .cornerRadius(16)
                    .frame(width: 40, height: 36)
                Image(systemName: setType == setTypeSelection ? iconFilled : icon)
                    .customFont(size: .caption, weight: .medium, kerning: 0, design: .rounded)
                    .foregroundStyle(setType == setTypeSelection ? .linearGradient(colors: [
                        Color(setTypeColorLight),
                        Color(setTypeColorDark),
                    ], startPoint: .top, endPoint: .bottom) : .linearGradient(colors: [
                        .secondary
                    ], startPoint: .top, endPoint: .bottom))
            }
        }
    }
}
