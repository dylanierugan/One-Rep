//
//  ManualLogButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct ManualLogButton: View {
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                Rectangle()
                    .cornerRadius(16)
                    .foregroundColor(.secondary.opacity(0.05))
                    .frame(width: 40, height: 36)
                
                HStack {
                    Image(systemName: "chevron.up")
                }
                .customFont(size: .caption, weight: .medium, kerning: 0, design: .rounded)
                .foregroundColor(.secondary)
            }
        }
    }
}
