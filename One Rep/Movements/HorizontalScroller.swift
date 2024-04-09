//
//  HorizontalScroller.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/26/24.
//

import SwiftUI

struct HorizontalScroller: View {
    
    @EnvironmentObject var themeColor: ThemeColorModel
    
    @Binding var muscleSelection: String
    @State var muscleGroups = ["All", Muscles.Arms.description, Muscles.Back.description, Muscles.Chest.description, Muscles.Core.description, Muscles.Legs.description, Muscles.Shoulders.description]
    
    var body: some View {
        
        /// Horizontal scrollview to allow for muscle group selection
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(muscleGroups, id: \.self) { muscleGroup in
                    Button {
                        muscleSelection = muscleGroup
                    } label: {
                        HStack {
                            Text(muscleGroup)
                                .padding(.trailing, 16)
                            if muscleGroup == "All" {
                                Image(systemName: Icons.Infinity.description)
                                    .font(.body.weight(.bold))
                            } else {
                                Image(muscleGroup.lowercased())
                                    .font(.body.weight(.regular))
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .foregroundColor(muscleSelection == muscleGroup ? Color(themeColor.Base) : Color(themeColor.Base).opacity(0.3))
                        .customFont(size: .body, weight: .semibold, kerning: 1, design: .rounded)
                        .background(Color(themeColor.BackgroundElement))
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(muscleSelection == muscleGroup ? .linearGradient(colors: [
                                    Color(themeColor.BaseLight),
                                    Color(themeColor.Base),
                                    Color(themeColor.BaseDark)
                                ], startPoint: .topLeading, endPoint: .bottomTrailing) : .linearGradient(colors: [
                                    .clear
                                ], startPoint: .top, endPoint: .bottom), lineWidth: 5)
                        )
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 3, y: 3)
                    }
                }
            }
            .padding(16)
            .onChange(of: muscleSelection) { newValue, _ in
                HapticManager.instance.impact(style: .soft)
            }
        }
    }
}
