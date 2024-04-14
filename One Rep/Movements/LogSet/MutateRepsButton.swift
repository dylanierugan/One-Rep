//
//  MutateRepsButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct MutateRepsButton: View {
    
    var color: Color
    var icon: String
    var mutatingValue: Int
    var mutateRep:(Int) -> Void
    
    var body: some View {
        Button {
            mutateRep(mutatingValue)
            HapticManager.instance.impact(style: .soft)
        } label: {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title3.weight(.bold))
        }
    }
}
