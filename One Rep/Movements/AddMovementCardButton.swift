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
                            Image(systemName: Icons.PlusCircle.description)
                                .foregroundColor(.black)
                                .font(Font.title2.weight(.medium))
                            Spacer()
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
            .frame(height: 84)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                    .opacity(0.4)
            )
            .padding(.horizontal, 16)
        }
    }
}
