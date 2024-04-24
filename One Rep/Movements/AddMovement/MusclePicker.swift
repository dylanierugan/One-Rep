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
    
    @Binding var muscleGroup: String
    
    var muscles: [String]
    
    // MARK: - View
    
    var body: some View {
        Picker("Muscle Group", selection: $muscleGroup) {
            ForEach(muscles, id: \.self) {
                Text($0)
                    .customFont(size: .body, weight: .medium, kerning: 1, design: .rounded)
                    .foregroundColor(.primary)
            }
        }
        .pickerStyle(.wheel)
        .background(Color(theme.BackgroundElementColor))
        .cornerRadius(12)
    }
}
