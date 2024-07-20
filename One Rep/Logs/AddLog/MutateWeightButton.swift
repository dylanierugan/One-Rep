//
//  MutateWeightButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct MutateWieghtButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var logController: LogController
    
    // MARK: - Public Properties
    
    @State var isEditing: Bool
    var color: Color
    var icon: String
    var mutatingValue: Double
    
    // MARK: - View
    
    var body: some View {
        Button {
            if isEditing {
                logController.mutateEditWeight(mutatingValue)
            } else {
                logController.mutateWeight(mutatingValue)
            }
            HapticManager.instance.impact(style: .soft)
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(.secondary.opacity(0.075))
                    .frame(width: 36, height: 36)
                    .cornerRadius(8)
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.title3.weight(.semibold))
            }
        }
    }
}
