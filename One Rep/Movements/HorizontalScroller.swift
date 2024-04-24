//
//  HorizontalScroller.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/26/24.
//

import SwiftUI

struct HorizontalScroller: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    
    @Binding var muscleSelection: String
    
    var muscleGroups = ["All", Muscles.Arms.description, Muscles.Back.description, Muscles.Chest.description, Muscles.Core.description, Muscles.Legs.description, Muscles.Shoulders.description]
    
    // MARK: - View
    
    var body: some View {
        /// Horizontal scrollview to allow for muscle group selection
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(muscleGroups, id: \.self) { muscleGroup in
                    Button {
                        muscleSelection = muscleGroup
                    } label: {
                        HStack {
                            HStack {
                                if muscleGroup == "All" {
                                    Image(systemName: Icons.Infinity.description)
                                        .font(.caption.weight(.bold))
                                        .padding(.trailing, 16)
                                } else {
                                    Image(muscleGroup.lowercased())
                                        .font(.caption.weight(.regular))
                                        .padding(.trailing, 16)
                                }
                            }
                            .foregroundColor(muscleSelection == muscleGroup ? Color(theme.lightBaseColor) : Color(theme.darkBaseColor).opacity(0.2))
                            Text(muscleGroup)
                                .foregroundColor(muscleSelection == muscleGroup ? .primary : .secondary.opacity(0.5))
                        }
                        .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                    .background(muscleSelection == muscleGroup ? Color(theme.BackgroundElementColor) : Color(theme.BackgroundElementColor).opacity(0.3))
                    .cornerRadius(16)
                }
            }
        }
        .padding(.horizontal, 16)
        .onChange(of: muscleSelection) { newValue, _ in
            HapticManager.instance.impact(style: .soft)
        }
    }
}
