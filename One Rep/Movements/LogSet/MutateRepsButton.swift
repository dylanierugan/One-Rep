//
//  MutateRepsButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct MutateRepsButton: View {
    
    // MARK: - Variables
    
    var color: Color
    var icon: String
    var mutatingValue: Int
    var mutateRep:(Int) -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            mutateRep(mutatingValue)
            HapticManager.instance.impact(style: .soft)
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(.secondary.opacity(0.05))
                    .frame(width: 36, height: 36)
                    .cornerRadius(8)
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.title3.weight(.semibold))
            }
        }
    }
}
