//
//  SetTypeButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct SetTypeButton: View {
    
    var color: Color
    var icon: String
    var iconFilled: String
    var setType: String
    @Binding var setTypeSelection: String
    @Binding var setTypeColor: Color
    
    var body: some View {
        Button {
            withAnimation {
                setTypeSelection = setType
                setTypeColor = color
            }
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(setType == setTypeSelection ? color.opacity(0.1) : .secondary.opacity(0.05))
                    .cornerRadius(16)
                    .frame(width: 40, height: 36)
                Image(systemName: setType == setTypeSelection ? iconFilled : icon)
                    .customFont(size: .caption, weight: .medium, kerning: 0, design: .rounded)
                    .foregroundColor(setType == setTypeSelection ? color : .secondary)
            }
        }
    }
}
