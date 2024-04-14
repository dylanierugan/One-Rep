//
//  BodyWeightButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct BodyWeightButton: View {
    
    @EnvironmentObject var theme: ThemeModel
    @Binding var isBodyWeightSelected: Bool
    
    var body: some View {
        Button {
            withAnimation {
                isBodyWeightSelected.toggle()
            }
        } label: {
            ZStack {
                Rectangle()
                    .cornerRadius(16)
                    .foregroundColor(isBodyWeightSelected ? Color(theme.BaseBlue).opacity(0.05) : .secondary.opacity(0.05))
                    .frame(width: 40, height: 36)
                
                HStack {
                    Image(systemName: "figure.stand")
                }
                .customFont(size: .caption, weight: .medium, kerning: 0, design: .rounded)
                .foregroundColor(isBodyWeightSelected ? Color(theme.BaseBlue) : .secondary)
            }
        }
    }
}
