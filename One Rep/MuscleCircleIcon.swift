//
//  MuscleCircleIcon.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/20/24.
//

import SwiftUI

struct MuscleCircleIcon: View {
    
    @EnvironmentObject var theme: ThemeModel
    var movement: Movement
    var size: CGFloat
    var font: Font
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: size, height: size)
                .foregroundStyle(Color(theme.BaseColor).opacity(0.1))
            Image(movement.muscleGroup.lowercased())
                .font(font)
                .foregroundStyle(.linearGradient(colors: [
                    Color(theme.BaseLightColor),
                    Color(theme.BaseColor)
                ], startPoint: .top, endPoint: .bottom))
        }
    }
}
