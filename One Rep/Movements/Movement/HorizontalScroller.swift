//
//  HorizontalScroller.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/26/24.
//

import SwiftUI

struct HorizontalScroller: View {
    
    @EnvironmentObject var theme: ThemeModel
    
    @Binding var muscleSelection: MuscleType
    
    // MARK: - View
    
    var body: some View {
        /// Horizontal scrollview to allow for muscle group selection
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(MuscleType.allCases, id: \.rawValue) { muscleGroup in
                    Button {
                        muscleSelection = muscleGroup
                        HapticManager.instance.impact(style: .soft)
                    } label: {
                        HStack {
                            HStack {
                                if muscleGroup == .All {
                                    Image(systemName: Icons.Infinity.description)
                                        .font(.caption.weight(.bold))
                                        .padding(.trailing, 16)
                                } else {
                                    Image(muscleGroup.rawValue.lowercased())
                                        .font(.caption.weight(.regular))
                                        .padding(.trailing, 16)
                                }
                            }
                            .foregroundStyle(muscleSelection == muscleGroup ?
                                .linearGradient(colors: [
                                    Color(theme.lightBaseColor),
                                    Color(theme.darkBaseColor)
                                ], startPoint: .top, endPoint: .bottom) :
                                .linearGradient(colors: [
                                    Color(theme.lightBaseColor).opacity(0.5),
                                    Color(theme.darkBaseColor).opacity(0.5)
                                ], startPoint: .top, endPoint: .bottom))
                            Text(muscleGroup.rawValue)
                                .foregroundColor(muscleSelection == muscleGroup ? .primary : .secondary.opacity(0.5))
                        }
                        .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                    .background(muscleSelection == muscleGroup ? Color(theme.backgroundElementColor) : Color(theme.backgroundElementColor).opacity(0.5))
                    .cornerRadius(16)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}
