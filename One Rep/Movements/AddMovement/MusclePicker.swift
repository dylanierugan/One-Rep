//
//  MusclePicker.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import SwiftUI

struct MusclePicker: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    
    @Binding var muscleGroup: MuscleType
    
    // MARK: - View
    
    var body: some View {
        Picker("Muscle Group", selection: $muscleGroup) {
            ForEach(MuscleType.allCases, id: \.rawValue) { muscle in
                if muscle != .All {
                    Text(muscle.rawValue)
                        .customFont(size: .body, weight: .medium, kerning: 1, design: .rounded)
                        .foregroundColor(.primary)
                        .tag(muscle)
                }
            }
        }
        .pickerStyle(.wheel)
        .background(Color(theme.backgroundElementColor))
        .cornerRadius(12)
    }
}
