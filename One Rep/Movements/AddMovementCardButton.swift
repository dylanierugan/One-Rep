//
//  AddMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import SwiftUI

struct AddMovementCardButton: View {
    
    @Binding var showAddMovementPopup: Bool
    
    var body: some View {
        Button {
            showAddMovementPopup = true
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            HStack {
                                Image(systemName: Icons.Plus.description)
                                    .font(Font.body.weight(.medium))
                                    .foregroundColor(.secondary.opacity(0.5))
                                Text("New Movement")
                                    .customFont(size: .body, weight: .medium, kerning: 1, design: .rounded)
                                    .foregroundColor(.secondary.opacity(0.5))
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
            .frame(height: 70)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                    .foregroundColor(.secondary.opacity(0.6))
                    .opacity(0.4)
            )
            .padding(.horizontal, 16)
        }
    }
}
