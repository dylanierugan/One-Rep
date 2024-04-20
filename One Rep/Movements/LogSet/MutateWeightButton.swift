//
//  MutateWeightButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct MutateWieghtButton: View {
    
    var color: Color
    var icon: String
    var mutatingValue: Double
    var mutateWeight:(Double) -> Void
    
    var body: some View {
        Button {
            mutateWeight(mutatingValue)
            HapticManager.instance.impact(style: .soft)
        } label: {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.body.weight(.bold))
        }
        .frame(width: 32, height: 32)
        .background(Color(color).opacity(0.05))
        .cornerRadius(8)
    }
}
