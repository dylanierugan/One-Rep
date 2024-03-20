//
//  MusclePicker.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import SwiftUI

struct MusclePicker: View {
    
    var muscles: [String]
    @Binding var muscleGroup: String
    
    var body: some View {
        Picker("Muscle Group", selection: $muscleGroup) {
            ForEach(muscles, id: \.self) {
                Text($0)
                    .font(.body)
            }
        }
        .pickerStyle(.wheel)
        .overlay(
        RoundedRectangle(cornerRadius: 12)
            .stroke(.ultraThickMaterial, lineWidth: 5)
            .allowsHitTesting(false))
        .cornerRadius(12)
    }
}
