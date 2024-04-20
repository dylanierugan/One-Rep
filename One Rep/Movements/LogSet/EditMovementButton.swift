//
//  EditMovementButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct EditMovementButton: View {
    
    @Binding var showEditMovementPopup: Bool
    
    var body: some View {
        Button {
            showEditMovementPopup.toggle()
        } label: {
            HStack {
                Image(systemName: Icons.RectangleAndPencilAndEllipsis.description)
            }
            .customFont(size: .caption, weight: .bold, kerning: 0, design: .rounded)
            .foregroundColor(.primary)
        }
    }
}
